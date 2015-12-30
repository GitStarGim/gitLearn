#! /usr/bin/env python3
# -*- coding:utf-8 -*-
age=int(input('please enter you age:'))
if age >= 18:
	print('age is %d'%age)
	print('adult')
elif age > 6:
	print('age is %d'%age)
	print('teenager')
else:
	print('kid')

