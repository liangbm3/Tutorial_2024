// Generated by gencpp from file package_pub_sub/randomdata.msg
// DO NOT EDIT!


#ifndef PACKAGE_PUB_SUB_MESSAGE_RANDOMDATA_H
#define PACKAGE_PUB_SUB_MESSAGE_RANDOMDATA_H


#include <string>
#include <vector>
#include <memory>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace package_pub_sub
{
template <class ContainerAllocator>
struct randomdata_
{
  typedef randomdata_<ContainerAllocator> Type;

  randomdata_()
    : id(0)
    , value(0.0)
    , timestamp()  {
    }
  randomdata_(const ContainerAllocator& _alloc)
    : id(0)
    , value(0.0)
    , timestamp(_alloc)  {
  (void)_alloc;
    }



   typedef int32_t _id_type;
  _id_type id;

   typedef double _value_type;
  _value_type value;

   typedef std::basic_string<char, std::char_traits<char>, typename std::allocator_traits<ContainerAllocator>::template rebind_alloc<char>> _timestamp_type;
  _timestamp_type timestamp;





  typedef boost::shared_ptr< ::package_pub_sub::randomdata_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::package_pub_sub::randomdata_<ContainerAllocator> const> ConstPtr;

}; // struct randomdata_

typedef ::package_pub_sub::randomdata_<std::allocator<void> > randomdata;

typedef boost::shared_ptr< ::package_pub_sub::randomdata > randomdataPtr;
typedef boost::shared_ptr< ::package_pub_sub::randomdata const> randomdataConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::package_pub_sub::randomdata_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::package_pub_sub::randomdata_<ContainerAllocator> >::stream(s, "", v);
return s;
}


template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator==(const ::package_pub_sub::randomdata_<ContainerAllocator1> & lhs, const ::package_pub_sub::randomdata_<ContainerAllocator2> & rhs)
{
  return lhs.id == rhs.id &&
    lhs.value == rhs.value &&
    lhs.timestamp == rhs.timestamp;
}

template<typename ContainerAllocator1, typename ContainerAllocator2>
bool operator!=(const ::package_pub_sub::randomdata_<ContainerAllocator1> & lhs, const ::package_pub_sub::randomdata_<ContainerAllocator2> & rhs)
{
  return !(lhs == rhs);
}


} // namespace package_pub_sub

namespace ros
{
namespace message_traits
{





template <class ContainerAllocator>
struct IsMessage< ::package_pub_sub::randomdata_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::package_pub_sub::randomdata_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::package_pub_sub::randomdata_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::package_pub_sub::randomdata_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::package_pub_sub::randomdata_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::package_pub_sub::randomdata_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::package_pub_sub::randomdata_<ContainerAllocator> >
{
  static const char* value()
  {
    return "c8e0535bc1f6fa1ce5082bcc285bb831";
  }

  static const char* value(const ::package_pub_sub::randomdata_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xc8e0535bc1f6fa1cULL;
  static const uint64_t static_value2 = 0xe5082bcc285bb831ULL;
};

template<class ContainerAllocator>
struct DataType< ::package_pub_sub::randomdata_<ContainerAllocator> >
{
  static const char* value()
  {
    return "package_pub_sub/randomdata";
  }

  static const char* value(const ::package_pub_sub::randomdata_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::package_pub_sub::randomdata_<ContainerAllocator> >
{
  static const char* value()
  {
    return "int32 id\n"
"float64 value\n"
"string timestamp\n"
;
  }

  static const char* value(const ::package_pub_sub::randomdata_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::package_pub_sub::randomdata_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.id);
      stream.next(m.value);
      stream.next(m.timestamp);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct randomdata_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::package_pub_sub::randomdata_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::package_pub_sub::randomdata_<ContainerAllocator>& v)
  {
    s << indent << "id: ";
    Printer<int32_t>::stream(s, indent + "  ", v.id);
    s << indent << "value: ";
    Printer<double>::stream(s, indent + "  ", v.value);
    s << indent << "timestamp: ";
    Printer<std::basic_string<char, std::char_traits<char>, typename std::allocator_traits<ContainerAllocator>::template rebind_alloc<char>>>::stream(s, indent + "  ", v.timestamp);
  }
};

} // namespace message_operations
} // namespace ros

#endif // PACKAGE_PUB_SUB_MESSAGE_RANDOMDATA_H