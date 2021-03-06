// RUN: %clang_cc1 %s -triple spir-unknown-unknown -cl-std=c++ -emit-llvm -pedantic -verify -O0 -o /dev/null
// RUN: %clang_cc1 %s -triple spir-unknown-unknown -cl-std=c++ -emit-llvm -pedantic -verify -O3 -o /dev/null

namespace test1
{
template <typename T>
void X0(T p) { }

int a;
__constant int f = 1;
kernel void k_test1()
{
  __private int b;
  int &c = b;
  __local int d;
  const int &e = b;
  X0(a);
  X0(static_cast<__global int &>(a));
  X0<int &>(a);
  X0<__generic int &>(a);
  X0<__global int &>(a);
  X0(b);
  X0(static_cast<__private int &>(b));
  X0<int &>(b);
  X0<__generic int &>(b);
  X0<__private int &>(b);
  X0(c);
  X0(d);
  X0(static_cast<__local int &>(d));
  X0<int &>(d);
  X0<__generic int &>(d);
  X0<__local int &>(d);
  X0(e);
  X0(f);
  X0(static_cast<__constant int &>(f));
  X0<__constant int &>(f);
}

}

////////////////////////////////////////////////////////////
namespace test2
{
template <typename T>
void X0(const T p) { }

int a;
__constant int f = 1;
kernel void k_test2()
{
  __private int b;
  int &c = b;
  __local int d;
  const int &e = b;
  X0(a);
  X0(static_cast<__global int &>(a));
  X0<int &>(a);
  X0<__generic int &>(a);
  X0<__global int &>(a);
  X0(b);
  X0(static_cast<__private int &>(b));
  X0<int &>(b);
  X0<__generic int &>(b);
  X0<__private int &>(b);
  X0(c);
  X0(d);
  X0(static_cast<__local int &>(d));
  X0<int &>(d);
  X0<__generic int &>(d);
  X0<__local int &>(d);
  X0(e);
  X0(f);
  X0(static_cast<__constant int &>(f));
  X0<__constant int &>(f);
}

}

////////////////////////////////////////////////////////////
namespace test3
{
template <typename T>
void X0(T& p) { }

int a;
__constant int f = 1;
kernel void k_test3()
{
  __private int b;
  int &c = b;
  __local int d;
  const int &e = b;
  X0(a);
  //X0<int>(a); //TODO: should it work?
  X0<__generic int>(a);
  X0<__global int>(a);
  X0(b);
  X0<int>(b);
  X0<__generic int>(b);
  X0<__private int>(b);
  X0(c);
  X0(d);
  //X0<int>(d); //TODO: should it work?
  X0<__generic int>(d);
  X0<__local int>(d);
  X0(e);
  X0(f);
  X0<__constant int>(f);
}

}

////////////////////////////////////////////////////////////
namespace test4
{
template <typename T>
void X0(const T& p) { }

int a;
__constant int f = 1;
kernel void k_test4()
{
  __private int b;
  int &c = b;
  __local int d;
  const int &e = b;
  X0(a);
  //X0<int>(a); //TODO: should it work?
  X0<__generic int>(a);
  X0<__global int>(a);
  X0(b);
  X0<int>(b);
  X0<__generic int>(b);
  X0<__private int>(b);
  X0(c);
  X0(d);
  //X0<int>(d); //TODO: should it work?
  X0<__generic int>(d);
  X0<__local int>(d);
  X0(e);
  X0(f);
  X0<__constant int>(f);
}

}

////////////////////////////////////////////////////////////
namespace test5
{
template <typename T>
void X0(__private T& p) { }

void fun()
{
  __private int b;
  X0(b);
  X0<int>(b);
  X0<__generic int>(b);
  X0<__private int>(b);
}

}

////////////////////////////////////////////////////////////
namespace test6
{
template <typename T>
void X0(const __private T& p) { }

void fun()
{
  __private int b;
  X0(b);
  X0<int>(b);
  X0<__generic int>(b);
  X0<__private int>(b);
}

}

////////////////////////////////////////////////////////////
namespace test7
{
template <typename T>
void X0(__generic T& p) { }

int a;
__constant int f = 1;
kernel void k_test7()
{
  int b;
  int &c = b;
  __local int d;
  const int &e = b;
  X0(a);
  X0<int>(a);
  X0<__generic int>(a);
  X0<__global int>(a);
  X0(b);
  X0<int>(b);
  X0<__generic int>(b);
  X0<__private int>(b);
  X0(c);
  X0(d);
  X0<int>(d);
  X0<__generic int>(d);
  X0<__local int>(d);
  X0(e);
  //X0<__constant int>(f);
}

}

////////////////////////////////////////////////////////////
namespace test8
{
template <typename T>
void X0(const __generic T& p) { }

int a;
__constant int f = 1;
kernel void k_test8()
{
  int b;
  int &c = b;
  __local int d;
  const int &e = b;
  X0(a);
  X0<int>(a);
  X0<__generic int>(a);
  X0<__global int>(a);
  X0(b);
  X0<int>(b);
  X0<__generic int>(b);
  X0<__private int>(b);
  X0(c);
  X0(d);
  X0<int>(d);
  X0<__generic int>(d);
  X0<__local int>(d);
  X0(e);
  //X0<__constant int>(f);
}

}

////////////////////////////////////////////////////////////
namespace test9
{
template <typename T>
void X0(__global T& p) { }

int a;
__constant int f = 1;
void fun()
{
  const __global int &b = a;
  X0(a); 
  X0<int>(a); 
  X0<__global int>(a); 
  X0<__generic int>(a);
  //X0<__constant int>(f); //TODO: should it work?
  X0(b);
}

}

////////////////////////////////////////////////////////////
namespace test10
{
template <typename T>
void X0(const __global T& p) { }

int a;
__constant int f = 1;
void fun()
{
  const __global int &b = a;
  X0(a); 
  X0<int>(a); 
  X0<__global int>(a); 
  X0<__generic int>(a);
  //X0<__constant int>(f); //TODO: should it work?
  X0(b);
}

}

////////////////////////////////////////////////////////////
namespace test11
{
template <int& N> struct X1 { X1(); };
template <int& N> X1<N>::X1() { }

template <__global int& N> struct X2 { X2(); };
template <__global int& N> X2<N>::X2() { }

template <__generic int& N> struct X3 { X3(); };
template <__generic int& N> X3<N>::X3() { }

template <__private int& N> struct X4 { X4(); };
template <__private int& N> X4<N>::X4() { }

int i = 42;

void fun()
{
  X1<i> a;
  X2<i> b; 
  X3<i> c;
}

}

////////////////////////////////////////////////////////////
namespace test12
{
template <class T = int &> struct X1 { };
template <class T = __generic int &> struct X2 { };

void fun()
{
  X1<> a;
  X2<> b;
}

}

/////////////////////////////////////////////////////////////
namespace test13
{
template<class T>
T func2(T *v)
{
  T a; //expected-error {{automatic variable qualified with an address space}} 
  return a;
}

int gvar;
auto a = gvar;

kernel void k_test13()
{
   func2(&gvar);  //expected-note {{in instantiation of function template specialization 'test13::func2<__global int>' requested here}}
}
}