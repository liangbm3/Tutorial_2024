// Auto-generated. Do not edit!

// (in-package service_pkg.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------


//-----------------------------------------------------------

class TwoNumbersRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.a = null;
      this.b = null;
    }
    else {
      if (initObj.hasOwnProperty('a')) {
        this.a = initObj.a
      }
      else {
        this.a = 0;
      }
      if (initObj.hasOwnProperty('b')) {
        this.b = initObj.b
      }
      else {
        this.b = 0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type TwoNumbersRequest
    // Serialize message field [a]
    bufferOffset = _serializer.int32(obj.a, buffer, bufferOffset);
    // Serialize message field [b]
    bufferOffset = _serializer.int32(obj.b, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type TwoNumbersRequest
    let len;
    let data = new TwoNumbersRequest(null);
    // Deserialize message field [a]
    data.a = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [b]
    data.b = _deserializer.int32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 8;
  }

  static datatype() {
    // Returns string type for a service object
    return 'service_pkg/TwoNumbersRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'ef8322123148e475e3e93a1f609b2f70';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 a
    int32 b
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new TwoNumbersRequest(null);
    if (msg.a !== undefined) {
      resolved.a = msg.a;
    }
    else {
      resolved.a = 0
    }

    if (msg.b !== undefined) {
      resolved.b = msg.b;
    }
    else {
      resolved.b = 0
    }

    return resolved;
    }
};

class TwoNumbersResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.sum = null;
      this.product = null;
      this.is_equal = null;
    }
    else {
      if (initObj.hasOwnProperty('sum')) {
        this.sum = initObj.sum
      }
      else {
        this.sum = 0;
      }
      if (initObj.hasOwnProperty('product')) {
        this.product = initObj.product
      }
      else {
        this.product = 0;
      }
      if (initObj.hasOwnProperty('is_equal')) {
        this.is_equal = initObj.is_equal
      }
      else {
        this.is_equal = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type TwoNumbersResponse
    // Serialize message field [sum]
    bufferOffset = _serializer.int32(obj.sum, buffer, bufferOffset);
    // Serialize message field [product]
    bufferOffset = _serializer.int32(obj.product, buffer, bufferOffset);
    // Serialize message field [is_equal]
    bufferOffset = _serializer.bool(obj.is_equal, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type TwoNumbersResponse
    let len;
    let data = new TwoNumbersResponse(null);
    // Deserialize message field [sum]
    data.sum = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [product]
    data.product = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [is_equal]
    data.is_equal = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 9;
  }

  static datatype() {
    // Returns string type for a service object
    return 'service_pkg/TwoNumbersResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '219128328f5ff69c7b09c9e924a43c10';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 sum
    int32 product
    bool is_equal
    
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new TwoNumbersResponse(null);
    if (msg.sum !== undefined) {
      resolved.sum = msg.sum;
    }
    else {
      resolved.sum = 0
    }

    if (msg.product !== undefined) {
      resolved.product = msg.product;
    }
    else {
      resolved.product = 0
    }

    if (msg.is_equal !== undefined) {
      resolved.is_equal = msg.is_equal;
    }
    else {
      resolved.is_equal = false
    }

    return resolved;
    }
};

module.exports = {
  Request: TwoNumbersRequest,
  Response: TwoNumbersResponse,
  md5sum() { return 'c9430c0754d7eee705aa42d6ef2f22e7'; },
  datatype() { return 'service_pkg/TwoNumbers'; }
};
