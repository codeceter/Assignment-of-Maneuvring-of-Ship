<script type="text/javascript" async src="https://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-MML-AM_CHTML"> </script>
<!--<script type="text/javascript" src="https://stackedit.io/libs/MathJax/MathJax.js?config=TeX-AMS_HTML"></script>-->
# 操纵性大作业说明文档 #
1. **实验目标**
基于Abkowitz非线性数学模型，构建关于船舶运动与舵角的操纵性常微分方程，求解模拟船舶在下列三个试验中的运动状态：
  * 回转试验
  * 回舵试验
  * Z形操纵试验
通过模拟这些试验，加深对船舶操纵与横摇课的认识、理解，形象地了解这些试验的详细步骤、目的。
2. **具体实现**
  基于MATLAB实现，共有5个代码文件，详细介绍如下：
  |文件名  |类型  |功能  |备注
  |----------|--------|------------|--------
  |solveODE.m | 函数 |导出模型| 利用Abkowitz非线性模型，将Marine船型给出的导数有因次化，并导出常微分方程组。
  |newmodel.m |函数  |求解常微分方程| 基于龙格库塔四阶算法，根据给定初始值计算给定常微分方程组的解矩阵。
  |divert.m | 脚本 | 回转试验 |进行回转试验，得到船舶运行轨迹及航向角速度r的曲线。
  |back.m| 脚本|回舵试验 |进行回舵试验，得到船舶航向角变化和航向角速度r变化曲线。
  |zigzag.m|脚本|Z形试验|进行Z形试验，测定船舶的操纵响应性能。
  使用时，直接调用三个脚本即可：

    divert
    %回转试验
    back
    %回舵试验
    zigzag
    %Z形试验
3. **详细介绍**

  * 模型的建立
    模型的建立实质是就是Marine船型水动力导数的有因次化和常微分方程组的导出。该过程最终得到如下图所示的常微分方程组：
$$
\begin{cases}
\begin{matrix}
\frac{du}{dt} = f_1(u, v, r, \delta) \\
\frac{dv}{dt} = f_2(u, v, r, \delta) \\
\frac{dr}{dt} = f_3(u, v, r, \delta)
\end{matrix}
\end{cases}
$$
  * 利用龙格库塔积分求解
  Abkowitz非线性模型导出了一个常微分方程组。四阶龙格库塔方法提供了形如$\frac{dy}{dt} = f(x,y) $的求解，但注意到该试中的y是一个单值，所求解的常微分方程只有一个因变量。因此，要求解此常微分方程组，必须对已有龙格库塔方法进行扩充。
  构建一个向量Y  = $\begin{bmatrix}u \\
v \\
r \\
\delta
\end{bmatrix}'$，这样，有$$\frac{dY}{dt} = \begin{bmatrix}
\frac{du}{dt} \\
\frac{dv}{dt} \\
\frac{dr}{dt} \\
\frac{d\delta}{dt}
\end{bmatrix} = \begin{bmatrix}
 f_1(u, v, r, \delta) \\
 f_2(u, v, r, \delta) \\
 f_3(u, v, r, \delta) \\
 0
\end{bmatrix} = F(x,Y)$$
在$\delta$已知时，该方程就可以通过龙格库塔方法求积分。

	Y = solveODE(F, 0, [u0, v0, r0, delta], t);
