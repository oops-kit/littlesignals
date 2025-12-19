export enum AppView {
  LANDING = 'LANDING',
  MODE_SELECTION = 'MODE_SELECTION',
  CALIBRATION = 'CALIBRATION',
  TEST_ATTENTION = 'TEST_ATTENTION',
  TEST_IMPULSIVITY = 'TEST_IMPULSIVITY',
  REPORT = 'REPORT',
}

export enum TestType {
  ATTENTION = 'ATTENTION',
  IMPULSIVITY = 'IMPULSIVITY',
}

export interface ChildProfile {
  dateOfBirth: string;
  ageMonths: number;
}

export interface AttentionResult {
  durationSeconds: number;
  totalMoves: number;
  errors: number; // Re-checking known cards
  completionStatus: 'completed' | 'abandoned';
}

export interface ImpulsivityResult {
  reactionTimeAverage: number;
  commissionErrors: number; // Tapping Red
  omissionErrors: number; // Missing Blue
  totalStimuli: number;
  completionStatus: 'completed' | 'abandoned';
}

export interface AppState {
  view: AppView;
  profile: ChildProfile | null;
  activeTest: TestType | null;
  attentionResult: AttentionResult | null;
  impulsivityResult: ImpulsivityResult | null;
}

export type BalloonColor = 'blue' | 'red';

export interface BalloonState {
  id: number;
  color: BalloonColor;
  x: number; // Percentage 10-90
  y: number; // Percentage 10-90
  isVisible: boolean;
  spawnTime: number;
}
