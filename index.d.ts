export interface PedometerInterface {
  startDate: number;
  endDate: number;
  numberOfSteps: number;
  distance: number;
}

export interface PedometerErrorInterface {
  code: number;
  message: string;
}

type Callback = (error: string | null, available: boolean) => any;

type Listener = (data: PedometerInterface | PedometerErrorInterface) => any;

declare const _default: {
  isStepCountingAvailable: (callback: Callback) => void;
  isDistanceAvailable: (callback: Callback) => void;
  isFloorCountingAvailable: (callback: Callback) => void;
  isPaceAvailable: (callback: Callback) => void;
  isCadenceAvailable: (callback: Callback) => void;
  startPedometerUpdatesFromDate: (date: number, listener: Listener) => void;
  queryPedometerDataBetweenDates: (startDate: number, endDate: number, listener: Listener) => void;
  stopPedometerUpdates: () => void;
};

export default _default;
