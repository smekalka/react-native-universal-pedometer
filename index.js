import React from 'react';
import {DeviceEventEmitter, NativeModules} from 'react-native';

const {BMDPedometer} = NativeModules;

const EventEmitter = new DeviceEventEmitter(BMDPedometer);

export default {
    isStepCountingAvailable: callback => {
        BMDPedometer.isStepCountingAvailable(callback);
    },

    isDistanceAvailable: callback => {
        BMDPedometer.isDistanceAvailable(callback);
    },

    isFloorCountingAvailable: callback => {
        BMDPedometer.isFloorCountingAvailable(callback);
    },

    isPaceAvailable: callback => {
        BMDPedometer.isPaceAvailable(callback);
    },

    isCadenceAvailable: callback => {
        BMDPedometer.isCadenceAvailable(callback);
    },

    startPedometerUpdatesFromDate: (date, handler) => {
        BMDPedometer.startPedometerUpdatesFromDate(date);
        DeviceEventEmitter.addListener('pedometerDataDidUpdate', handler);
    },

    queryPedometerDataBetweenDates: (startDate, endDate, handler) => {
        BMDPedometer.queryPedometerDataBetweenDates(startDate, endDate, handler);
    },

    stopPedometerUpdates: () => {
        BMDPedometer.stopPedometerUpdates();
    }
};
