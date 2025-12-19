import React, { useState, useEffect, useRef } from 'react';
import { BalloonColor, BalloonState } from '../types';

interface ImpulsivityTestProps {
  onComplete: (result: any) => void;
  onExit: () => void;
}

const TOTAL_STIMULI = 15; // Short test for demo, usually 20-30
const BLUE_RATIO = 0.7;

export const ImpulsivityTest: React.FC<ImpulsivityTestProps> = ({ onComplete, onExit }) => {
  const [gameState, setGameState] = useState<'intro' | 'playing' | 'finished'>('intro');
  const [currentBalloon, setCurrentBalloon] = useState<BalloonState | null>(null);
  const [stimuliCount, setStimuliCount] = useState(0);
  
  // Metrics
  const [metrics, setMetrics] = useState({
    commissionErrors: 0, // Clicked Red
    omissionErrors: 0, // Missed Blue
    reactionTimes: [] as number[],
  });

  const timerRef = useRef<ReturnType<typeof setTimeout> | null>(null);
  const startTimeRef = useRef<number>(0);

  // Intro countdown
  useEffect(() => {
    let t: ReturnType<typeof setTimeout>;
    if (gameState === 'intro') {
      t = setTimeout(() => setGameState('playing'), 2000);
    }
    return () => clearTimeout(t);
  }, [gameState]);

  // Game Loop
  useEffect(() => {
    if (gameState !== 'playing') return;

    if (stimuliCount >= TOTAL_STIMULI) {
      finishTest();
      return;
    }

    scheduleNextBalloon();

    return () => {
      if (timerRef.current) clearTimeout(timerRef.current);
    };
  }, [gameState, stimuliCount]);

  const scheduleNextBalloon = () => {
    // 1.5s to 2.5s interval
    const delay = Math.random() * 1000 + 1500;
    
    timerRef.current = setTimeout(() => {
      spawnBalloon();
    }, delay);
  };

  const spawnBalloon = () => {
    // Check previous balloon omission (if it was blue and we are spawning a new one, implies miss)
    // Note: In this simple implementation, if balloon is still there, it's a miss.
    // But we will auto-hide balloon after 1s.
    
    const isBlue = Math.random() < BLUE_RATIO;
    const color: BalloonColor = isBlue ? 'blue' : 'red';
    
    // Random Position (avoid edges)
    const x = Math.random() * 60 + 20; // 20% to 80%
    const y = Math.random() * 60 + 20;

    const balloon: BalloonState = {
      id: Date.now(),
      color,
      x,
      y,
      isVisible: true,
      spawnTime: Date.now()
    };

    setCurrentBalloon(balloon);
    startTimeRef.current = Date.now();

    // Auto hide after 1.2s (if not clicked)
    setTimeout(() => {
      handleTimeout(balloon.id, color);
    }, 1200);
  };

  const handleTimeout = (id: number, color: BalloonColor) => {
    setCurrentBalloon(prev => {
      if (prev && prev.id === id && prev.isVisible) {
        // Balloon expired without click
        if (color === 'blue') {
          // Omission Error
          setMetrics(m => ({ ...m, omissionErrors: m.omissionErrors + 1 }));
        }
        return null; // Hide balloon
      }
      return prev;
    });
    
    // Advance count only after balloon is gone
    setStimuliCount(c => c + 1);
  };

  const handleBalloonClick = () => {
    if (!currentBalloon) return;

    const reactionTime = Date.now() - startTimeRef.current;
    const { color } = currentBalloon;

    if (color === 'blue') {
      // Success
      // Play pop sound ideally
      setMetrics(m => ({ 
        ...m, 
        reactionTimes: [...m.reactionTimes, reactionTime] 
      }));
    } else {
      // Commission Error (Clicked Red)
      setMetrics(m => ({ ...m, commissionErrors: m.commissionErrors + 1 }));
      // Optional: Visual shake effect
    }

    // Hide immediately on click
    setCurrentBalloon(null);
  };

  const finishTest = () => {
    setGameState('finished');
    const avgRT = metrics.reactionTimes.length > 0 
      ? metrics.reactionTimes.reduce((a, b) => a + b, 0) / metrics.reactionTimes.length
      : 0;

    onComplete({
      reactionTimeAverage: avgRT,
      commissionErrors: metrics.commissionErrors,
      omissionErrors: metrics.omissionErrors,
      totalStimuli: TOTAL_STIMULI,
      completionStatus: 'completed'
    });
  };

  return (
    <div className="w-full h-full bg-sky-50 relative overflow-hidden select-none">
      {/* HUD */}
      <div className="absolute top-0 left-0 w-full p-4 flex justify-between z-10">
        <div className="text-sky-800 font-bold">Balloon Game</div>
        <button onClick={onExit} className="text-sky-400 font-bold text-sm">Exit</button>
      </div>

      {gameState === 'intro' && (
        <div className="absolute inset-0 flex items-center justify-center bg-black/10 z-20">
          <div className="text-4xl font-bold text-sky-600 animate-pulse">Get Ready!</div>
        </div>
      )}

      {currentBalloon && (
        <div 
          onClick={handleBalloonClick}
          className={`absolute w-24 h-32 rounded-full cursor-pointer transition-transform active:scale-90
            ${currentBalloon.color === 'blue' ? 'bg-blue-500 shadow-blue-300' : 'bg-red-500 shadow-red-300'}
            shadow-xl border-b-4 border-black/10
          `}
          style={{ 
            left: `${currentBalloon.x}%`, 
            top: `${currentBalloon.y}%`,
            transform: 'translate(-50%, -50%)' 
          }}
        >
          {/* Balloon string */}
          <div className="absolute top-full left-1/2 w-0.5 h-12 bg-gray-400 -translate-x-1/2 origin-top"></div>
          {/* Shine */}
          <div className="absolute top-4 left-4 w-6 h-10 bg-white/30 rounded-full rotate-12"></div>
        </div>
      )}
    </div>
  );
};