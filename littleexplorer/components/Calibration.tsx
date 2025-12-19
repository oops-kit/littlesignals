import React, { useState } from 'react';

interface CalibrationProps {
  onComplete: () => void;
}

export const Calibration: React.FC<CalibrationProps> = ({ onComplete }) => {
  const [popped, setPopped] = useState(0);

  const handlePop = (e: React.MouseEvent) => {
    e.stopPropagation();
    const newCount = popped + 1;
    setPopped(newCount);
    if (newCount >= 3) {
      setTimeout(onComplete, 500);
    }
  };

  return (
    <div className="w-full h-full bg-slate-50 flex flex-col items-center justify-center p-8 text-center space-y-8">
      <h2 className="text-2xl font-bold text-slate-700">Warm Up</h2>
      <p className="text-slate-500">Let the child tap 3 bubbles to start!</p>
      
      <div className="relative w-64 h-32">
         {[...Array(3)].map((_, i) => (
           popped <= i && (
             <button
               key={i}
               onClick={handlePop}
               className="w-16 h-16 bg-purple-400 rounded-full shadow-lg absolute animate-bounce flex items-center justify-center text-white font-bold hover:bg-purple-500 active:scale-95 transition-all"
               style={{ 
                 left: `${i * 35}%`, 
                 animationDelay: `${i * 0.2}s` 
               }}
             >
               POP
             </button>
           )
         ))}
      </div>
    </div>
  );
};