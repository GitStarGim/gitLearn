#!/usr/bin/env python3
# -*- coding:utf-8 -*-
import math
def my_abs(a):
	if not isinstance(a,(int,float)):
		raise TypeError('bad type')
	if(a>0):
		return a
	else:
		return -a


def move(x,y,step,angle):
	nx=x+step*math.cos(angle)
	ny=y+step*math.sin(angle)
	return nx,ny

def power(x,n=2):
	s=1
	while(n>0):
		n=n-1
		s=s*x
	return s

def add_end(L=None):
	if L is None:
		L=[]
	L.append('end')
	return L

def sum(*numbers):
	sum=0
	for n in numbers:
		sum+=n
	return sum

def person(name,age,*,city='beijing',job):
	print('name:',name,'age:',age,city,job)


def fact(n):
	if n==1:
		return 1
	else:
		return n*fact(n-1)

def hanota(n,a,b,c):
	if n==1:
		print(a,'->',c)
		return
	else:
		hanota(n-1,a,c,b)
		print(a,'->',c)
		hanota(n-1,b,a,c)

