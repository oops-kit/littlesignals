import React, { useState, useMemo } from 'react';
import { AppState, AppView, ChildProfile, TestType } from './types';
import { AttentionTest } from './components/AttentionTest';
import { ImpulsivityTest } from './components/ImpulsivityTest';
import { ResultChart } from './components/ResultChart';
import { Calibration } from './components/Calibration';
import { Info, Play, ChevronRight, Activity, Brain } from 'lucide-react';

const App: React.FC = () => {
  const [state, setState] = useState<AppState>({
    view: AppView.LANDING,
    profile: null,
    activeTest: null,
    attentionResult: null,
    impulsivityResult: null,
  });

  const [dobInput, setDobInput] = useState('');

  // --- Handlers ---

  const handleStartSetup = () => {
    if (!dobInput) return alert("Please enter date of birth");
    const birthDate = new Date(dobInput);
    const ageMonths = (Date.now() - birthDate.getTime()) / (1000 * 60 * 60 * 24 * 30.44);
    
    setState(prev => ({
      ...prev,
      profile: { dateOfBirth: dobInput, ageMonths },
      view: AppView.MODE_SELECTION
    }));
  };

  const handleSelectMode = (mode: TestType) => {
    setState(prev => ({
      ...prev,
      activeTest: mode,
      view: AppView.CALIBRATION
    }));
  };

  const handleCalibrationComplete = () => {
    setState(prev => ({
      ...prev,
      view: prev.activeTest === TestType.ATTENTION ? AppView.TEST_ATTENTION : AppView.TEST_IMPULSIVITY
    }));
  };

  const handleTestComplete = (result: any) => {
    setState(prev => ({
      ...prev,
      [prev.activeTest === TestType.ATTENTION ? 'attentionResult' : 'impulsivityResult']: result,
      view: AppView.REPORT
    }));
  };

  const handleExitTest = () => {
    if(confirm("Stop the game? Progress will be lost.")) {
      setState(prev => ({ ...prev, view: AppView.MODE_SELECTION, activeTest: null }));
    }
  };

  // --- Views ---

  const renderLanding = () => (
    <div className="min-h-screen flex flex-col items-center justify-center p-6 text-center max-w-md mx-auto">
      <div className="bg-white p-8 rounded-2xl shadow-xl space-y-6 w-full">
        <div className="flex justify-center mb-4">
          <div className="bg-blue-100 p-4 rounded-full">
            <Brain size={48} className="text-blue-600" />
          </div>
        </div>
        <h1 className="text-3xl font-bold text-slate-800 tracking-tight">LittleExplorer</h1>
        <p className="text-slate-500 text-sm leading-relaxed">
          A playful observation tool for parents to understand their child's developing mind. 
          <br/><span className="font-bold text-slate-700 mt-2 block">Not a medical diagnosis.</span>
        </p>

        <div className="space-y-2 text-left">
          <label className="text-xs font-bold text-slate-400 uppercase tracking-wider">Child's Birthday</label>
          <input 
            type="date" 
            className="w-full p-3 bg-slate-50 rounded-lg border border-slate-200 focus:outline-none focus:ring-2 focus:ring-blue-400 text-slate-700"
            value={dobInput}
            onChange={(e) => setDobInput(e.target.value)}
          />
        </div>

        <button 
          onClick={handleStartSetup}
          className="w-full bg-blue-600 text-white py-4 rounded-xl font-bold text-lg shadow-lg hover:bg-blue-700 transition-colors flex items-center justify-center gap-2"
        >
          Start <ChevronRight size={20}/>
        </button>
      </div>
    </div>
  );

  const renderSelection = () => (
    <div className="min-h-screen bg-slate-50 p-6 flex flex-col">
      <header className="mb-8">
        <h2 className="text-2xl font-bold text-slate-800">What would you like to observe?</h2>
        <p className="text-slate-500">Select a playful activity for your child.</p>
      </header>

      <div className="grid gap-6 md:grid-cols-2 flex-1">
        <div 
          onClick={() => handleSelectMode(TestType.ATTENTION)}
          className="bg-white p-6 rounded-2xl shadow-sm border border-slate-100 cursor-pointer hover:border-orange-300 hover:shadow-md transition-all group"
        >
          <div className="bg-orange-100 w-12 h-12 rounded-full flex items-center justify-center mb-4 group-hover:scale-110 transition-transform">
            <Brain className="text-orange-600" />
          </div>
          <h3 className="text-xl font-bold text-slate-800 mb-2">Attention</h3>
          <p className="text-slate-500 text-sm mb-4">"Does my child struggle to focus on one thing?"</p>
          <div className="text-orange-600 font-bold text-sm flex items-center">Start Activity <ChevronRight size={16}/></div>
        </div>

        <div 
          onClick={() => handleSelectMode(TestType.IMPULSIVITY)}
          className="bg-white p-6 rounded-2xl shadow-sm border border-slate-100 cursor-pointer hover:border-sky-300 hover:shadow-md transition-all group"
        >
          <div className="bg-sky-100 w-12 h-12 rounded-full flex items-center justify-center mb-4 group-hover:scale-110 transition-transform">
            <Activity className="text-sky-600" />
          </div>
          <h3 className="text-xl font-bold text-slate-800 mb-2">Impulse Control</h3>
          <p className="text-slate-500 text-sm mb-4">"Does my child act before listening?"</p>
          <div className="text-sky-600 font-bold text-sm flex items-center">Start Activity <ChevronRight size={16}/></div>
        </div>
      </div>
      
      <div className="mt-8 text-center text-xs text-slate-400">
        Please enable "Do Not Disturb" on your device.
      </div>
    </div>
  );

  const renderReport = () => {
    const isAttention = state.activeTest === TestType.ATTENTION;
    const result = isAttention ? state.attentionResult : state.impulsivityResult;

    if (!result) return null;

    // Calculate normalized scores for visualization
    // Note: These formulas are illustrative logic for the prototype
    let visualScore = 50;
    let title = "";
    let desc = "";
    let tips: string[] = [];
    let lowLabel = "";
    let highLabel = "";

    if (isAttention) {
      const ar = result as any;
      // Lower duration and fewer moves is better, but this is Age 3-4.
      // High errors = Low attention.
      visualScore = 100 - (Math.min(ar.errors * 10, 50) + Math.min(ar.durationSeconds / 2, 40)); 
      title = visualScore > 40 ? "Steady Explorer" : "Free Explorer";
      desc = visualScore > 40 
        ? "Your child showed good focus for their age, methodically finding matches." 
        : "Your child prefers exploring quickly over sustained focus. This is common at this age.";
      lowLabel = "Free Spirit";
      highLabel = "Deep Focus";
      tips = [
        "Present one toy at a time to encourage deeper play.",
        "Read short stories and ask simple questions to build working memory."
      ];
    } else {
      const ir = result as any;
      // High commission errors = High impulsivity.
      visualScore = 100 - (ir.commissionErrors * 15); 
      title = visualScore > 50 ? "Careful Observer" : "High-Energy Action Leader";
      desc = visualScore > 50 
        ? "Your child demonstrated strong ability to wait and check before acting." 
        : "Your child reacts with enthusiasm and speed! Breaking and waiting are skills still in development.";
      lowLabel = "High Energy";
      highLabel = "Calm Control";
      tips = [
        "Play 'Freeze Dance' games to practice stopping on cue.",
        "Practice waiting turns during daily routines (e.g., elevator buttons)."
      ];
    }

    return (
      <div className="min-h-screen bg-slate-50 p-6 overflow-y-auto">
        <h2 className="text-2xl font-bold text-slate-800 mb-6 text-center">Observation Summary</h2>
        
        <div className="max-w-md mx-auto space-y-6">
          <div className="bg-white p-6 rounded-2xl shadow-sm border border-slate-100 text-center">
            <div className="text-sm font-bold text-slate-400 uppercase tracking-wider mb-2">Behavior Style</div>
            <h3 className="text-3xl font-bold text-blue-600 mb-2">{title}</h3>
            <p className="text-slate-600">{desc}</p>
          </div>

          <ResultChart 
            score={visualScore} 
            label="Typical Range for Age 3-4" 
            lowLabel={lowLabel}
            highLabel={highLabel}
            description="Comparison against typical developmental milestones."
          />

          <div className="bg-blue-50 p-6 rounded-2xl border border-blue-100">
            <h4 className="font-bold text-blue-800 mb-4 flex items-center gap-2">
              <Info size={18} />
              Parenting Tips
            </h4>
            <ul className="space-y-3">
              {tips.map((tip, i) => (
                <li key={i} className="flex gap-3 text-blue-900 text-sm">
                  <span className="w-1.5 h-1.5 bg-blue-400 rounded-full mt-1.5 shrink-0"></span>
                  {tip}
                </li>
              ))}
            </ul>
          </div>

          <button 
            onClick={() => setState(prev => ({ ...prev, view: AppView.MODE_SELECTION, activeTest: null }))}
            className="w-full bg-white text-slate-600 py-4 rounded-xl font-bold border border-slate-200 hover:bg-slate-50"
          >
            Observe Another Trait
          </button>

          <p className="text-xs text-slate-400 text-center mt-4 pb-8">
            Disclaimer: This result is an observation aid, not a medical diagnosis. 
            Results can be affected by sleep, hunger, or mood.
          </p>
        </div>
      </div>
    );
  };

  // --- Render Switch ---

  return (
    <div className="font-sans text-slate-900 h-screen w-screen overflow-hidden">
      {state.view === AppView.LANDING && renderLanding()}
      {state.view === AppView.MODE_SELECTION && renderSelection()}
      {state.view === AppView.CALIBRATION && <Calibration onComplete={handleCalibrationComplete} />}
      {state.view === AppView.TEST_ATTENTION && <AttentionTest onComplete={handleTestComplete} onExit={handleExitTest} />}
      {state.view === AppView.TEST_IMPULSIVITY && <ImpulsivityTest onComplete={handleTestComplete} onExit={handleExitTest} />}
      {state.view === AppView.REPORT && renderReport()}
    </div>
  );
};

export default App;
