'use strict';

var React = require('react-native');

var {
    DeviceEventEmitter
} = React;

var RNPedometer = React.NativeModules.BMDPedometer;

var Pedometer = {
  isStepCountingAvailable: function(callback) {
        RNPedometer.isStepCountingAvailable(callback);
      },

  isDistanceAvailable: function(callback) {
        RNPedometer.isDistanceAvailable(callback);
      },

  isFloorCountingAvailable: function(callback) {
        RNPedometer.isFloorCountingAvailable(callback);
      },

  isPaceAvailable: function(callback) {
        RNPedometer.isPaceAvailable(callback);
      },

  isCadenceAvailable: function(callback) {
        RNPedometer.isCadenceAvailable(callback);
      },

  startPedometerUpdatesFromDate: function(date, handler) {
        RNPedometer.startPedometerUpdatesFromDate(date);
    DeviceEventEmitter.addListener(
            'pedometerDataDidUpdate',
            handler
          );
      },

  queryPedometerDataBetweenDates: function(startDate, endDate, handler) {
        RNPedometer.queryPedometerDataBetweenDates(startDate, endDate, handler);
      },

  stopPedometerUpdates: function () {
        RNPedometer.stopPedometerUpdates();
      }

};

module.exports = Pedometer;

