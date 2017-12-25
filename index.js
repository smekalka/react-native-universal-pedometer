'use strict';

import { NativeModules, NativeEventEmitter } from 'react-native';
const { BMDPedometer } = NativeModules;

const EventEmitter = new NativeEventEmitter(BMDPedometer);
let subscription;

var Pedometer = {
  isStepCountingAvailable: function(callback) {
      BMDPedometer.isStepCountingAvailable(callback);
  },

  isDistanceAvailable: function(callback) {
      BMDPedometer.isDistanceAvailable(callback);
  },

  isFloorCountingAvailable: function(callback) {
      BMDPedometer.isFloorCountingAvailable(callback);
  },

  isPaceAvailable: function(callback) {
      BMDPedometer.isPaceAvailable(callback);
  },

  isCadenceAvailable: function(callback) {
      BMDPedometer.isCadenceAvailable(callback);
  },

  startPedometerUpdatesFromDate: function(date, handler) {
      BMDPedometer.startPedometerUpdatesFromDate(date);

      subscription = EventEmitter.addListener(
          'pedometerDataDidUpdate',
          handler
      );
  },

  queryPedometerDataBetweenDates: function(startDate, endDate, handler) {
      BMDPedometer.queryPedometerDataBetweenDates(startDate, endDate, handler);
  },

  stopPedometerUpdates: function () {
      BMDPedometer.stopPedometerUpdates();

      if (subscription) {
          subscription.remove();
      }
  }
};

module.exports = Pedometer;

