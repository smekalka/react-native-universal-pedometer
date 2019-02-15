interface Pedometer {
  startDate: number;
  endDate: number;
  numberOfSteps: number;
  distance: number;
}

interface PedometerError {
  code: number;
  message: string;
}

type Callback = (error: string | null, available: boolean) => any;

type Listener = (data: Pedometer | PedometerError) => any;

declare const _default: {
  isStepCountingAvailable: (callback: Callback) => void;
  isDistanceAvailable: (callback: Callback) => void;
  isFloorCountingAvailable: (callback: Callback) => void;
  isCadenceAvailable: (callback: Callback) => void;
  startPedometerUpdatesFromDate: (date: () => number, listener: Listener) => void;
  startStepsDetection: (listener: Listener) => void;
  queryPedometerDataBetweenDates: (startDate: () => number, endDate: () => number, handler: Listener) => void;
  stopPedometerUpdates: () => void;
};

export default _default;
