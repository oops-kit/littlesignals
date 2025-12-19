import React, { useState, useEffect, useRef } from 'react';
import { LucideIcon, Cat, Dog, Rabbit, Fish, Bird, Snail } from 'lucide-react';

interface AttentionTestProps {
  onComplete: (result: any) => void;
  onExit: () => void;
}

interface Card {
  id: number;
  icon: LucideIcon;
  name: string;
  isFlipped: boolean;
  isMatched: boolean;
  wiggle: boolean;
}

const ICONS = [Cat, Dog, Rabbit, Fish]; // Level 1 is 3 pairs, we have extras

export const AttentionTest: React.FC<AttentionTestProps> = ({ onComplete, onExit }) => {
  const [cards, setCards] = useState<Card[]>([]);
  const [level, setLevel] = useState(1);
  const [flippedCards, setFlippedCards] = useState<number[]>([]);
  const [isProcessing, setIsProcessing] = useState(false);
  const [startTime] = useState(Date.now());
  const [moves, setMoves] = useState(0);
  const [errors, setErrors] = useState(0); // Re-clicks on known cards (simplified proxy)
  
  const interactionTimer = useRef<ReturnType<typeof setTimeout> | null>(null);

  // Initialize Game
  useEffect(() => {
    setupLevel(level);
    return () => clearInteractionTimer();
  }, [level]);

  // Interaction Timer (Wiggle Hint)
  useEffect(() => {
    resetInteractionTimer();
    return () => clearInteractionTimer();
  }, [flippedCards, cards]); // Reset on any interaction

  const setupLevel = (lvl: number) => {
    const pairCount = lvl === 1 ? 3 : 4;
    const selectedIcons = ICONS.slice(0, pairCount);
    
    // Create pairs
    let deck: Card[] = [];
    selectedIcons.forEach((Icon, index) => {
      deck.push({ id: index * 2, icon: Icon, name: `animal-${index}`, isFlipped: false, isMatched: false, wiggle: false });
      deck.push({ id: index * 2 + 1, icon: Icon, name: `animal-${index}`, isFlipped: false, isMatched: false, wiggle: false });
    });

    // Shuffle
    deck = deck.sort(() => Math.random() - 0.5);
    setCards(deck);
    setFlippedCards([]);
    setIsProcessing(false);
  };

  const clearInteractionTimer = () => {
    if (interactionTimer.current) clearTimeout(interactionTimer.current);
  };

  const resetInteractionTimer = () => {
    clearInteractionTimer();
    // Only set wiggle if not processing and game not over
    if (cards.some(c => !c.isMatched)) {
      interactionTimer.current = setTimeout(() => {
        triggerWiggle();
      }, 5000); // 5 seconds of inactivity
    }
  };

  const triggerWiggle = () => {
    // Find a card that is not matched and not flipped
    // Ideally find a match for an already flipped card if one exists, otherwise random
    setCards(prev => {
      const available = prev.findIndex(c => !c.isMatched && !c.isFlipped);
      if (available !== -1) {
        const newCards = [...prev];
        newCards[available].wiggle = true;
        return newCards;
      }
      return prev;
    });

    // Remove wiggle after animation
    setTimeout(() => {
      setCards(prev => prev.map(c => ({ ...c, wiggle: false })));
    }, 1000);
  };

  const handleCardClick = (id: number) => {
    if (isProcessing) return;
    const clickedCard = cards.find(c => c.id === id);
    if (!clickedCard || clickedCard.isFlipped || clickedCard.isMatched) return;

    // Flip logic
    const newCards = cards.map(c => c.id === id ? { ...c, isFlipped: true, wiggle: false } : c);
    setCards(newCards);
    
    const newFlipped = [...flippedCards, id];
    setFlippedCards(newFlipped);

    if (newFlipped.length === 2) {
      setIsProcessing(true);
      setMoves(m => m + 1);
      checkForMatch(newFlipped, newCards);
    }
  };

  const checkForMatch = (currentFlipped: number[], currentCards: Card[]) => {
    const card1 = currentCards.find(c => c.id === currentFlipped[0]);
    const card2 = currentCards.find(c => c.id === currentFlipped[1]);

    if (card1 && card2 && card1.name === card2.name) {
      // Match!
      setTimeout(() => {
        setCards(prev => prev.map(c => 
          currentFlipped.includes(c.id) ? { ...c, isMatched: true, isFlipped: true } : c
        ));
        setFlippedCards([]);
        setIsProcessing(false);
        checkCompletion(currentCards); // Pass current state proxy
      }, 800);
    } else {
      // No Match
      setErrors(e => e + 1);
      setTimeout(() => {
        setCards(prev => prev.map(c => 
          currentFlipped.includes(c.id) ? { ...c, isFlipped: false } : c
        ));
        setFlippedCards([]);
        setIsProcessing(false);
      }, 1500);
    }
  };

  const checkCompletion = (currentCards: Card[]) => {
    // We need to check if all matched (including the ones just matched)
    // Actually, checking state inside timeout usually refers to old state closure, 
    // but here we just matched 2. If total matched + 2 == total cards.
    // Easier way: check if (matched count from state) + 2 === total.
    // However, safest is to assume if level 1 is done, go to level 2.
    
    // We can't rely on `cards` state immediately inside this function due to closure.
    // But we know we just matched a pair. 
    
    // Let's use an effect to watch for all matched.
  };

  useEffect(() => {
    if (cards.length > 0 && cards.every(c => c.isMatched)) {
      if (level === 1) {
        setTimeout(() => {
            // Play sound effect hook here ideally
            setLevel(2);
        }, 1000);
      } else {
        finishTest();
      }
    }
  }, [cards]);

  const finishTest = () => {
    const duration = (Date.now() - startTime) / 1000;
    onComplete({
      durationSeconds: duration,
      totalMoves: moves,
      errors: errors,
      completionStatus: 'completed'
    });
  };

  return (
    <div className="flex flex-col h-full bg-orange-50 relative overflow-hidden">
      {/* Header */}
      <div className="flex justify-between items-center p-4">
        <div className="text-orange-800 font-bold text-lg">Find Animal Friends</div>
        <button onClick={onExit} className="text-orange-400 font-bold text-sm">Exit</button>
      </div>

      {/* Game Area */}
      <div className="flex-1 flex items-center justify-center p-4">
        <div className={`grid gap-4 w-full max-w-2xl ${level === 1 ? 'grid-cols-3' : 'grid-cols-4'}`}>
          {cards.map(card => (
            <div 
              key={card.id}
              onClick={() => handleCardClick(card.id)}
              className={`
                aspect-square cursor-pointer perspective-1000 transition-transform duration-300
                ${card.wiggle ? 'animate-bounce' : ''}
              `}
            >
              <div className={`
                relative w-full h-full text-center transition-transform duration-500 transform-style-3d
                ${card.isFlipped ? 'rotate-y-180' : ''}
              `} style={{ transformStyle: 'preserve-3d', transform: card.isFlipped ? 'rotateY(180deg)' : 'rotateY(0deg)' }}>
                
                {/* Back of Card */}
                <div className="absolute w-full h-full bg-orange-400 rounded-xl border-4 border-white shadow-lg backface-hidden flex items-center justify-center">
                  <span className="text-4xl text-white font-bold opacity-50">?</span>
                </div>

                {/* Front of Card */}
                <div className="absolute w-full h-full bg-white rounded-xl border-4 border-orange-200 shadow-xl backface-hidden rotate-y-180 flex items-center justify-center"
                     style={{ backfaceVisibility: 'hidden', transform: 'rotateY(180deg)' }}>
                  {card.isMatched && <div className="absolute inset-0 bg-yellow-100 opacity-50 rounded-lg animate-pulse"></div>}
                  <card.icon size={48} className={card.isMatched ? 'text-green-500' : 'text-orange-500'} />
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
      
      <div className="p-4 text-center text-orange-400 text-sm">
        Level {level} / 2
      </div>
    </div>
  );
};