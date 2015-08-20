Return-Path: <rtc-linux+bncBDYN53XCUYHBB3VS2WXAKGQEPU6IOUA@googlegroups.com>
Date: Wed, 19 Aug 2015 21:37:00 -0700 (PDT)
From: suneelgarapati@gmail.com
To: rtc-linux <rtc-linux@googlegroups.com>
Cc: suneel.garapati@xilinx.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, anuragku@xilinx.com,
	michals@xilinx.com, sorenb@xilinx.com, anirudh@xilinx.com,
	punnaia@xilinx.com, moritz.fischer@ettus.com
Message-Id: <c713c202-1d5e-4656-9e4f-1e15bc4dac14@googlegroups.com>
In-Reply-To: <CAAtXAHf7Vngo8gz6cCRauxUSnrQgs4+UNGWpQ6wy0fvBPMQO_A@mail.gmail.com>
References: <1439978002-12157-1-git-send-email-suneel.garapati@xilinx.com>
 <1439978002-12157-2-git-send-email-suneel.garapati@xilinx.com>
 <CAAtXAHf7Vngo8gz6cCRauxUSnrQgs4+UNGWpQ6wy0fvBPMQO_A@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v3 2/2] drivers: rtc: add xilinx zynqmp rtc driver
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_6762_319695090.1440045420918"
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

------=_Part_6762_319695090.1440045420918
Content-Type: multipart/alternative;
	boundary="----=_Part_6763_1261719542.1440045420919"

------=_Part_6763_1261719542.1440045420919
Content-Type: text/plain; charset=UTF-8

Hi Moritz,

devm_ioremap_resource validates the argument pointer of struct resource. 
Hence no explicit validation of return value of platform_get_resource 
function.
It seems to be common practice with all other drivers in drivers/rtc.

Regards,
Suneel

On Wednesday, August 19, 2015 at 11:49:49 PM UTC+5:30, Moritz Fischer wrote:
>
> Hi Suneel, 
>
> looks good, minor nit below. 
>
> On Wed, Aug 19, 2015 at 2:53 AM, Suneel Garapati 
> <suneel....@xilinx.com <javascript:>> wrote: 
> > adds support for RTC controller found on 
> > Xilinx Zynq Ultrascale+ MPSoC platform. 
> > 
> > Signed-off-by: Suneel Garapati <suneel....@xilinx.com <javascript:>> 
> > --- 
> > Changes v3 
> > - fix checkpatch errors 
> > - check time in secs arg against max sec val 
> > - order header files 
> > - use ptr_err_or_zero macro 
> > - use time64 variants 
> > Changes v2 
> > - change alm to alarm 
> > --- 
> >  drivers/rtc/Kconfig      |   7 ++ 
> >  drivers/rtc/Makefile     |   1 + 
> >  drivers/rtc/rtc-zynqmp.c | 279 
> +++++++++++++++++++++++++++++++++++++++++++++++ 
> >  3 files changed, 287 insertions(+) 
> >  create mode 100644 drivers/rtc/rtc-zynqmp.c 
> > 
> > diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig 
> > index 35ea04c..bc96277 100644 
> > --- a/drivers/rtc/Kconfig 
> > +++ b/drivers/rtc/Kconfig 
> > @@ -1116,6 +1116,13 @@ config RTC_DRV_OPAL 
> >           This driver can also be built as a module. If so, the module 
> >           will be called rtc-opal. 
> > 
> > +config RTC_DRV_ZYNQMP 
> > +       tristate "Xilinx Zynq Ultrascale+ MPSoC RTC" 
> > +       depends on OF 
> > +       help 
> > +         If you say yes here you get support for the RTC controller 
> found on 
> > +         Xilinx Zynq Ultrascale+ MPSoC. 
> > + 
> >  comment "on-CPU RTC drivers" 
> > 
> >  config RTC_DRV_DAVINCI 
> > diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile 
> > index 2797384..e491eb5 100644 
> > --- a/drivers/rtc/Makefile 
> > +++ b/drivers/rtc/Makefile 
> > @@ -159,3 +159,4 @@ obj-$(CONFIG_RTC_DRV_WM831X)        += rtc-wm831x.o 
> >  obj-$(CONFIG_RTC_DRV_WM8350)   += rtc-wm8350.o 
> >  obj-$(CONFIG_RTC_DRV_X1205)    += rtc-x1205.o 
> >  obj-$(CONFIG_RTC_DRV_XGENE)    += rtc-xgene.o 
> > +obj-$(CONFIG_RTC_DRV_ZYNQMP)   += rtc-zynqmp.o 
> > diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c 
> > new file mode 100644 
> > index 0000000..8b28762 
> > --- /dev/null 
> > +++ b/drivers/rtc/rtc-zynqmp.c 
> > @@ -0,0 +1,279 @@ 
> > +/* 
> > + * Xilinx Zynq Ultrascale+ MPSoC Real Time Clock Driver 
> > + * 
> > + * Copyright (C) 2015 Xilinx, Inc. 
> > + * 
> > + * This program is free software; you can redistribute it and/or modify 
> it 
> > + * under the terms and conditions of the GNU General Public License, 
> > + * version 2, as published by the Free Software Foundation. 
> > + * 
> > + * This program is distributed in the hope it will be useful, but 
> WITHOUT 
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY 
> or 
> > + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License 
> for 
> > + * more details. 
> > + * 
> > + * You should have received a copy of the GNU General Public License 
> along with 
> > + * this program. If not, see <http://www.gnu.org/licenses/>. 
> > + * 
> > + */ 
> > + 
> > +#include <linux/delay.h> 
> > +#include <linux/init.h> 
> > +#include <linux/io.h> 
> > +#include <linux/module.h> 
> > +#include <linux/of.h> 
> > +#include <linux/platform_device.h> 
> > +#include <linux/rtc.h> 
> > + 
> > +/* RTC Registers */ 
> > +#define RTC_SET_TM_WR          0x00 
> > +#define RTC_SET_TM_RD          0x04 
> > +#define RTC_CALIB_WR           0x08 
> > +#define RTC_CALIB_RD           0x0C 
> > +#define RTC_CUR_TM             0x10 
> > +#define RTC_CUR_TICK           0x14 
> > +#define RTC_ALRM               0x18 
> > +#define RTC_INT_STS            0x20 
> > +#define RTC_INT_MASK           0x24 
> > +#define RTC_INT_EN             0x28 
> > +#define RTC_INT_DIS            0x2C 
> > +#define RTC_CTRL               0x40 
> > + 
> > +#define RTC_FR_EN              BIT(20) 
> > +#define RTC_FR_DATSHIFT                16 
> > +#define RTC_TICK_MASK          0xFFFF 
> > +#define RTC_INT_SEC            BIT(0) 
> > +#define RTC_INT_ALRM           BIT(1) 
> > +#define RTC_OSC_EN             BIT(24) 
> > + 
> > +#define RTC_CALIB_DEF          0x198233 
> > +#define RTC_CALIB_MASK         0x1FFFFF 
> > +#define RTC_SEC_MAX_VAL                0xFFFFFFFF 
> > + 
> > +struct xlnx_rtc_dev { 
> > +       struct rtc_device       *rtc; 
> > +       void __iomem            *reg_base; 
> > +       int                     alarm_irq; 
> > +       int                     sec_irq; 
> > +}; 
> > + 
> > +static int xlnx_rtc_set_time(struct device *dev, struct rtc_time *tm) 
> > +{ 
> > +       struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev); 
> > +       unsigned long new_time; 
> > + 
> > +       new_time = rtc_tm_to_time64(tm); 
> > + 
> > +       if (new_time > RTC_SEC_MAX_VAL) 
> > +               return -EINVAL; 
> > + 
> > +       writel(new_time, xrtcdev->reg_base + RTC_SET_TM_WR); 
> > + 
> > +       return 0; 
> > +} 
> > + 
> > +static int xlnx_rtc_read_time(struct device *dev, struct rtc_time *tm) 
> > +{ 
> > +       struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev); 
> > + 
> > +       rtc_time64_to_tm(readl(xrtcdev->reg_base + RTC_CUR_TM), tm); 
> > + 
> > +       return rtc_valid_tm(tm); 
> > +} 
> > + 
> > +static int xlnx_rtc_read_alarm(struct device *dev, struct rtc_wkalrm 
> *alrm) 
> > +{ 
> > +       struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev); 
> > + 
> > +       rtc_time64_to_tm(readl(xrtcdev->reg_base + RTC_ALRM), 
> &alrm->time); 
> > +       alrm->enabled = readl(xrtcdev->reg_base + RTC_INT_MASK) & 
> RTC_INT_ALRM; 
> > + 
> > +       return 0; 
> > +} 
> > + 
> > +static int xlnx_rtc_alarm_irq_enable(struct device *dev, u32 enabled) 
> > +{ 
> > +       struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev); 
> > + 
> > +       if (enabled) 
> > +               writel(RTC_INT_ALRM, xrtcdev->reg_base + RTC_INT_EN); 
> > +       else 
> > +               writel(RTC_INT_ALRM, xrtcdev->reg_base + RTC_INT_DIS); 
> > + 
> > +       return 0; 
> > +} 
> > + 
> > +static int xlnx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm 
> *alrm) 
> > +{ 
> > +       struct xlnx_rtc_dev *xrtcdev = dev_get_drvdata(dev); 
> > +       unsigned long alarm_time; 
> > + 
> > +       alarm_time = rtc_tm_to_time64(&alrm->time); 
> > + 
> > +       if (alarm_time > RTC_SEC_MAX_VAL) 
> > +               return -EINVAL; 
> > + 
> > +       writel((u32)alarm_time, (xrtcdev->reg_base + RTC_ALRM)); 
> > + 
> > +       xlnx_rtc_alarm_irq_enable(dev, alrm->enabled); 
> > + 
> > +       return 0; 
> > +} 
> > + 
> > +static void xlnx_init_rtc(struct xlnx_rtc_dev *xrtcdev, u32 calibval) 
> > +{ 
> > +       /* 
> > +        * Based on crystal freq of 33.330 KHz 
> > +        * set the seconds counter and enable, set fractions counter 
> > +        * to default value suggested as per design spec 
> > +        * to correct RTC delay in frequency over period of time. 
> > +        */ 
> > +       calibval &= RTC_CALIB_MASK; 
> > +       writel(calibval, (xrtcdev->reg_base + RTC_CALIB_WR)); 
> > +} 
> > + 
> > +static const struct rtc_class_ops xlnx_rtc_ops = { 
> > +       .set_time         = xlnx_rtc_set_time, 
> > +       .read_time        = xlnx_rtc_read_time, 
> > +       .read_alarm       = xlnx_rtc_read_alarm, 
> > +       .set_alarm        = xlnx_rtc_set_alarm, 
> > +       .alarm_irq_enable = xlnx_rtc_alarm_irq_enable, 
> > +}; 
> > + 
> > +static irqreturn_t xlnx_rtc_interrupt(int irq, void *id) 
> > +{ 
> > +       struct xlnx_rtc_dev *xrtcdev = (struct xlnx_rtc_dev *)id; 
> > +       unsigned int status; 
> > + 
> > +       status = readl(xrtcdev->reg_base + RTC_INT_STS); 
> > +       /* Check if interrupt asserted */ 
> > +       if (!(status & (RTC_INT_SEC | RTC_INT_ALRM))) 
> > +               return IRQ_NONE; 
> > + 
> > +       /* Clear interrupt */ 
> > +       writel(status, xrtcdev->reg_base + RTC_INT_STS); 
> > + 
> > +       if (status & RTC_INT_SEC) 
> > +               rtc_update_irq(xrtcdev->rtc, 1, RTC_IRQF | RTC_UF); 
> > +       if (status & RTC_INT_ALRM) 
> > +               rtc_update_irq(xrtcdev->rtc, 1, RTC_IRQF | RTC_AF); 
> > + 
> > +       return IRQ_HANDLED; 
> > +} 
> > + 
> > +static int xlnx_rtc_probe(struct platform_device *pdev) 
> > +{ 
> > +       struct xlnx_rtc_dev *xrtcdev; 
> > +       struct resource *res; 
> > +       int ret; 
> > +       unsigned int calibvalue; 
> > + 
> > +       xrtcdev = devm_kzalloc(&pdev->dev, sizeof(*xrtcdev), 
> GFP_KERNEL); 
> > +       if (!xrtcdev) 
> > +               return -ENOMEM; 
> > + 
> > +       platform_set_drvdata(pdev, xrtcdev); 
> > + 
> > +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0); 
> Do you want to check for return value here? 
> > + 
> > +       xrtcdev->reg_base = devm_ioremap_resource(&pdev->dev, res); 
> > +       if (IS_ERR(xrtcdev->reg_base)) 
> > +               return PTR_ERR(xrtcdev->reg_base); 
> > + 
> > +       xrtcdev->alarm_irq = platform_get_irq_byname(pdev, "alarm"); 
> > +       if (xrtcdev->alarm_irq < 0) { 
> > +               dev_err(&pdev->dev, "no irq resource\n"); 
> > +               return xrtcdev->alarm_irq; 
> > +       } 
> > +       ret = devm_request_irq(&pdev->dev, xrtcdev->alarm_irq, 
> > +                              xlnx_rtc_interrupt, 0, 
> > +                              dev_name(&pdev->dev), xrtcdev); 
> > +       if (ret) { 
> > +               dev_err(&pdev->dev, "request irq failed\n"); 
> > +               return ret; 
> > +       } 
> > + 
> > +       xrtcdev->sec_irq = platform_get_irq_byname(pdev, "sec"); 
> > +       if (xrtcdev->sec_irq < 0) { 
> > +               dev_err(&pdev->dev, "no irq resource\n"); 
> > +               return xrtcdev->sec_irq; 
> > +       } 
> > +       ret = devm_request_irq(&pdev->dev, xrtcdev->sec_irq, 
> > +                              xlnx_rtc_interrupt, 0, 
> > +                              dev_name(&pdev->dev), xrtcdev); 
> > +       if (ret) { 
> > +               dev_err(&pdev->dev, "request irq failed\n"); 
> > +               return ret; 
> > +       } 
> > + 
> > +       ret = of_property_read_u32(pdev->dev.of_node, "calibration", 
> > +                                  &calibvalue); 
> > +       if (ret) 
> > +               calibvalue = RTC_CALIB_DEF; 
> > + 
> > +       xlnx_init_rtc(xrtcdev, calibvalue); 
> > + 
> > +       device_init_wakeup(&pdev->dev, 1); 
> > + 
> > +       xrtcdev->rtc = devm_rtc_device_register(&pdev->dev, pdev->name, 
> > +                                        &xlnx_rtc_ops, THIS_MODULE); 
> > +       return PTR_ERR_OR_ZERO(xrtcdev->rtc); 
> > +} 
> > + 
> > +static int xlnx_rtc_remove(struct platform_device *pdev) 
> > +{ 
> > +       xlnx_rtc_alarm_irq_enable(&pdev->dev, 0); 
> > +       device_init_wakeup(&pdev->dev, 0); 
> > + 
> > +       return 0; 
> > +} 
> > + 
> > +static int __maybe_unused xlnx_rtc_suspend(struct device *dev) 
> > +{ 
> > +       struct platform_device *pdev = to_platform_device(dev); 
> > +       struct xlnx_rtc_dev *xrtcdev = platform_get_drvdata(pdev); 
> > + 
> > +       if (device_may_wakeup(&pdev->dev)) 
> > +               enable_irq_wake(xrtcdev->alarm_irq); 
> > +       else 
> > +               xlnx_rtc_alarm_irq_enable(dev, 0); 
> > + 
> > +       return 0; 
> > +} 
> > + 
> > +static int __maybe_unused xlnx_rtc_resume(struct device *dev) 
> > +{ 
> > +       struct platform_device *pdev = to_platform_device(dev); 
> > +       struct xlnx_rtc_dev *xrtcdev = platform_get_drvdata(pdev); 
> > + 
> > +       if (device_may_wakeup(&pdev->dev)) 
> > +               disable_irq_wake(xrtcdev->alarm_irq); 
> > +       else 
> > +               xlnx_rtc_alarm_irq_enable(dev, 1); 
> > + 
> > +       return 0; 
> > +} 
> > + 
> > +static SIMPLE_DEV_PM_OPS(xlnx_rtc_pm_ops, xlnx_rtc_suspend, 
> xlnx_rtc_resume); 
> > + 
> > +static const struct of_device_id xlnx_rtc_of_match[] = { 
> > +       {.compatible = "xlnx,zynqmp-rtc" }, 
> > +       { } 
> > +}; 
> > +MODULE_DEVICE_TABLE(of, xlnx_rtc_of_match); 
> > + 
> > +static struct platform_driver xlnx_rtc_driver = { 
> > +       .probe          = xlnx_rtc_probe, 
> > +       .remove         = xlnx_rtc_remove, 
> > +       .driver         = { 
> > +               .name   = KBUILD_MODNAME, 
> > +               .pm     = &xlnx_rtc_pm_ops, 
> > +               .of_match_table = xlnx_rtc_of_match, 
> > +       }, 
> > +}; 
> > + 
> > +module_platform_driver(xlnx_rtc_driver); 
> > + 
> > +MODULE_DESCRIPTION("Xilinx Zynq MPSoC RTC driver"); 
> > +MODULE_AUTHOR("Xilinx Inc."); 
> > +MODULE_LICENSE("GPL v2"); 
> > -- 
> > 2.1.2 
> > 
> > 
> > _______________________________________________ 
> > linux-arm-kernel mailing list 
> > linux-ar...@lists.infradead.org <javascript:> 
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel 
>
> Cheers, 
>
> Moritz 
>

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.

------=_Part_6763_1261719542.1440045420919
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Moritz,<div><br></div><div>devm_ioremap_resource valida=
tes the argument pointer of struct resource. Hence no explicit validation o=
f return value of platform_get_resource function.</div><div>It seems to be =
common practice with all other drivers in drivers/rtc.</div><div><br></div>=
<div>Regards,</div><div>Suneel</div><div><br>On Wednesday, August 19, 2015 =
at 11:49:49 PM UTC+5:30, Moritz Fischer wrote:<blockquote class=3D"gmail_qu=
ote" style=3D"margin: 0;margin-left: 0.8ex;border-left: 1px #ccc solid;padd=
ing-left: 1ex;">Hi Suneel,
<br>
<br>looks good, minor nit below.
<br>
<br>On Wed, Aug 19, 2015 at 2:53 AM, Suneel Garapati
<br>&lt;<a href=3D"javascript:" target=3D"_blank" gdf-obfuscated-mailto=3D"=
ScWhbjoKBQAJ" rel=3D"nofollow" onmousedown=3D"this.href=3D&#39;javascript:&=
#39;;return true;" onclick=3D"this.href=3D&#39;javascript:&#39;;return true=
;">suneel....@xilinx.com</a>&gt; wrote:
<br>&gt; adds support for RTC controller found on
<br>&gt; Xilinx Zynq Ultrascale+ MPSoC platform.
<br>&gt;
<br>&gt; Signed-off-by: Suneel Garapati &lt;<a href=3D"javascript:" target=
=3D"_blank" gdf-obfuscated-mailto=3D"ScWhbjoKBQAJ" rel=3D"nofollow" onmouse=
down=3D"this.href=3D&#39;javascript:&#39;;return true;" onclick=3D"this.hre=
f=3D&#39;javascript:&#39;;return true;">suneel....@xilinx.com</a>&gt;
<br>&gt; ---
<br>&gt; Changes v3
<br>&gt; - fix checkpatch errors
<br>&gt; - check time in secs arg against max sec val
<br>&gt; - order header files
<br>&gt; - use ptr_err_or_zero macro
<br>&gt; - use time64 variants
<br>&gt; Changes v2
<br>&gt; - change alm to alarm
<br>&gt; ---
<br>&gt; =C2=A0drivers/rtc/Kconfig =C2=A0 =C2=A0 =C2=A0| =C2=A0 7 ++
<br>&gt; =C2=A0drivers/rtc/Makefile =C2=A0 =C2=A0 | =C2=A0 1 +
<br>&gt; =C2=A0drivers/rtc/rtc-zynqmp.c | 279 +++++++++++++++++++++++++++++=
+<wbr>+++++++++++++++++
<br>&gt; =C2=A03 files changed, 287 insertions(+)
<br>&gt; =C2=A0create mode 100644 drivers/rtc/rtc-zynqmp.c
<br>&gt;
<br>&gt; diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
<br>&gt; index 35ea04c..bc96277 100644
<br>&gt; --- a/drivers/rtc/Kconfig
<br>&gt; +++ b/drivers/rtc/Kconfig
<br>&gt; @@ -1116,6 +1116,13 @@ config RTC_DRV_OPAL
<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 This driver can also be built a=
s a module. If so, the module
<br>&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 will be called rtc-opal.
<br>&gt;
<br>&gt; +config RTC_DRV_ZYNQMP
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 tristate &quot;Xilinx Zynq Ultrascale+ MPSo=
C RTC&quot;
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 depends on OF
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 help
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 If you say yes here you get support =
for the RTC controller found on
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 Xilinx Zynq Ultrascale+ MPSoC.
<br>&gt; +
<br>&gt; =C2=A0comment &quot;on-CPU RTC drivers&quot;
<br>&gt;
<br>&gt; =C2=A0config RTC_DRV_DAVINCI
<br>&gt; diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
<br>&gt; index 2797384..e491eb5 100644
<br>&gt; --- a/drivers/rtc/Makefile
<br>&gt; +++ b/drivers/rtc/Makefile
<br>&gt; @@ -159,3 +159,4 @@ obj-$(CONFIG_RTC_DRV_WM831X) =C2=A0 =C2=A0 =C2=
=A0 =C2=A0+=3D rtc-wm831x.o
<br>&gt; =C2=A0obj-$(CONFIG_RTC_DRV_WM8350) =C2=A0 +=3D rtc-wm8350.o
<br>&gt; =C2=A0obj-$(CONFIG_RTC_DRV_X1205) =C2=A0 =C2=A0+=3D rtc-x1205.o
<br>&gt; =C2=A0obj-$(CONFIG_RTC_DRV_XGENE) =C2=A0 =C2=A0+=3D rtc-xgene.o
<br>&gt; +obj-$(CONFIG_RTC_DRV_ZYNQMP) =C2=A0 +=3D rtc-zynqmp.o
<br>&gt; diff --git a/drivers/rtc/rtc-zynqmp.c b/drivers/rtc/rtc-zynqmp.c
<br>&gt; new file mode 100644
<br>&gt; index 0000000..8b28762
<br>&gt; --- /dev/null
<br>&gt; +++ b/drivers/rtc/rtc-zynqmp.c
<br>&gt; @@ -0,0 +1,279 @@
<br>&gt; +/*
<br>&gt; + * Xilinx Zynq Ultrascale+ MPSoC Real Time Clock Driver
<br>&gt; + *
<br>&gt; + * Copyright (C) 2015 Xilinx, Inc.
<br>&gt; + *
<br>&gt; + * This program is free software; you can redistribute it and/or =
modify it
<br>&gt; + * under the terms and conditions of the GNU General Public Licen=
se,
<br>&gt; + * version 2, as published by the Free Software Foundation.
<br>&gt; + *
<br>&gt; + * This program is distributed in the hope it will be useful, but=
 WITHOUT
<br>&gt; + * ANY WARRANTY; without even the implied warranty of MERCHANTABI=
LITY or
<br>&gt; + * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public L=
icense for
<br>&gt; + * more details.
<br>&gt; + *
<br>&gt; + * You should have received a copy of the GNU General Public Lice=
nse along with
<br>&gt; + * this program. If not, see &lt;<a href=3D"http://www.gnu.org/li=
censes/" target=3D"_blank" rel=3D"nofollow" onmousedown=3D"this.href=3D&#39=
;http://www.google.com/url?q\75http%3A%2F%2Fwww.gnu.org%2Flicenses%2F\46sa\=
75D\46sntz\0751\46usg\75AFQjCNFnr2jMTkZr2MjK7ZrTSh2fA8SobA&#39;;return true=
;" onclick=3D"this.href=3D&#39;http://www.google.com/url?q\75http%3A%2F%2Fw=
ww.gnu.org%2Flicenses%2F\46sa\75D\46sntz\0751\46usg\75AFQjCNFnr2jMTkZr2MjK7=
ZrTSh2fA8SobA&#39;;return true;">http://www.gnu.org/licenses/</a>&gt;<wbr>.
<br>&gt; + *
<br>&gt; + */
<br>&gt; +
<br>&gt; +#include &lt;linux/delay.h&gt;
<br>&gt; +#include &lt;linux/init.h&gt;
<br>&gt; +#include &lt;linux/io.h&gt;
<br>&gt; +#include &lt;linux/module.h&gt;
<br>&gt; +#include &lt;linux/of.h&gt;
<br>&gt; +#include &lt;linux/platform_device.h&gt;
<br>&gt; +#include &lt;linux/rtc.h&gt;
<br>&gt; +
<br>&gt; +/* RTC Registers */
<br>&gt; +#define RTC_SET_TM_WR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00
<br>&gt; +#define RTC_SET_TM_RD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x04
<br>&gt; +#define RTC_CALIB_WR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x08
<br>&gt; +#define RTC_CALIB_RD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0C
<br>&gt; +#define RTC_CUR_TM =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x10
<br>&gt; +#define RTC_CUR_TICK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x14
<br>&gt; +#define RTC_ALRM =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0x18
<br>&gt; +#define RTC_INT_STS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x20
<br>&gt; +#define RTC_INT_MASK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x24
<br>&gt; +#define RTC_INT_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x28
<br>&gt; +#define RTC_INT_DIS =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x2C
<br>&gt; +#define RTC_CTRL =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 0x40
<br>&gt; +
<br>&gt; +#define RTC_FR_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0BIT(20)
<br>&gt; +#define RTC_FR_DATSHIFT =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A016
<br>&gt; +#define RTC_TICK_MASK =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00xFFFF
<br>&gt; +#define RTC_INT_SEC =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BIT(=
0)
<br>&gt; +#define RTC_INT_ALRM =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT(1)
<br>&gt; +#define RTC_OSC_EN =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 BIT(=
24)
<br>&gt; +
<br>&gt; +#define RTC_CALIB_DEF =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x198233
<br>&gt; +#define RTC_CALIB_MASK =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1FFFFF
<br>&gt; +#define RTC_SEC_MAX_VAL =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A00xFFFFFFFF
<br>&gt; +
<br>&gt; +struct xlnx_rtc_dev {
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 struct rtc_device =C2=A0 =C2=A0 =C2=A0 *rtc=
;
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 void __iomem =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0*reg_base;
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 alarm_irq;
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sec_irq;
<br>&gt; +};
<br>&gt; +
<br>&gt; +static int xlnx_rtc_set_time(struct device *dev, struct rtc_time =
*tm)
<br>&gt; +{
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 struct xlnx_rtc_dev *xrtcdev =3D dev_get_dr=
vdata(dev);
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 unsigned long new_time;
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 new_time =3D rtc_tm_to_time64(tm);
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 if (new_time &gt; RTC_SEC_MAX_VAL)
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 writel(new_time, xrtcdev-&gt;reg_base + RTC=
_SET_TM_WR);
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 return 0;
<br>&gt; +}
<br>&gt; +
<br>&gt; +static int xlnx_rtc_read_time(struct device *dev, struct rtc_time=
 *tm)
<br>&gt; +{
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 struct xlnx_rtc_dev *xrtcdev =3D dev_get_dr=
vdata(dev);
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 rtc_time64_to_tm(readl(<wbr>xrtcdev-&gt;reg=
_base + RTC_CUR_TM), tm);
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 return rtc_valid_tm(tm);
<br>&gt; +}
<br>&gt; +
<br>&gt; +static int xlnx_rtc_read_alarm(struct device *dev, struct rtc_wka=
lrm *alrm)
<br>&gt; +{
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 struct xlnx_rtc_dev *xrtcdev =3D dev_get_dr=
vdata(dev);
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 rtc_time64_to_tm(readl(<wbr>xrtcdev-&gt;reg=
_base + RTC_ALRM), &amp;alrm-&gt;time);
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 alrm-&gt;enabled =3D readl(xrtcdev-&gt;reg_=
base + RTC_INT_MASK) &amp; RTC_INT_ALRM;
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 return 0;
<br>&gt; +}
<br>&gt; +
<br>&gt; +static int xlnx_rtc_alarm_irq_enable(<wbr>struct device *dev, u32=
 enabled)
<br>&gt; +{
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 struct xlnx_rtc_dev *xrtcdev =3D dev_get_dr=
vdata(dev);
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 if (enabled)
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writel(RTC_INT_=
ALRM, xrtcdev-&gt;reg_base + RTC_INT_EN);
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 else
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 writel(RTC_INT_=
ALRM, xrtcdev-&gt;reg_base + RTC_INT_DIS);
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 return 0;
<br>&gt; +}
<br>&gt; +
<br>&gt; +static int xlnx_rtc_set_alarm(struct device *dev, struct rtc_wkal=
rm *alrm)
<br>&gt; +{
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 struct xlnx_rtc_dev *xrtcdev =3D dev_get_dr=
vdata(dev);
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 unsigned long alarm_time;
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 alarm_time =3D rtc_tm_to_time64(&amp;alrm-&=
gt;time);
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 if (alarm_time &gt; RTC_SEC_MAX_VAL)
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 writel((u32)alarm_time, (xrtcdev-&gt;reg_ba=
se + RTC_ALRM));
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 xlnx_rtc_alarm_irq_enable(dev, alrm-&gt;ena=
bled);
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 return 0;
<br>&gt; +}
<br>&gt; +
<br>&gt; +static void xlnx_init_rtc(struct xlnx_rtc_dev *xrtcdev, u32 calib=
val)
<br>&gt; +{
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 /*
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Based on crystal freq of 33.330 KHz
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0* set the seconds counter and enable,=
 set fractions counter
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0* to default value suggested as per d=
esign spec
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0* to correct RTC delay in frequency o=
ver period of time.
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 calibval &amp;=3D RTC_CALIB_MASK;
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 writel(calibval, (xrtcdev-&gt;reg_base + RT=
C_CALIB_WR));
<br>&gt; +}
<br>&gt; +
<br>&gt; +static const struct rtc_class_ops xlnx_rtc_ops =3D {
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 .set_time =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D x=
lnx_rtc_set_time,
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 .read_time =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D x=
lnx_rtc_read_time,
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 .read_alarm =C2=A0 =C2=A0 =C2=A0 =3D xlnx_r=
tc_read_alarm,
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 .set_alarm =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D x=
lnx_rtc_set_alarm,
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 .alarm_irq_enable =3D xlnx_rtc_alarm_irq_en=
able,
<br>&gt; +};
<br>&gt; +
<br>&gt; +static irqreturn_t xlnx_rtc_interrupt(int irq, void *id)
<br>&gt; +{
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 struct xlnx_rtc_dev *xrtcdev =3D (struct xl=
nx_rtc_dev *)id;
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 unsigned int status;
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 status =3D readl(xrtcdev-&gt;reg_base + RTC=
_INT_STS);
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 /* Check if interrupt asserted */
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 if (!(status &amp; (RTC_INT_SEC | RTC_INT_A=
LRM)))
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return IRQ_NONE=
;
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 /* Clear interrupt */
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 writel(status, xrtcdev-&gt;reg_base + RTC_I=
NT_STS);
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 if (status &amp; RTC_INT_SEC)
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtc_update_irq(=
xrtcdev-&gt;rtc, 1, RTC_IRQF | RTC_UF);
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 if (status &amp; RTC_INT_ALRM)
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtc_update_irq(=
xrtcdev-&gt;rtc, 1, RTC_IRQF | RTC_AF);
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 return IRQ_HANDLED;
<br>&gt; +}
<br>&gt; +
<br>&gt; +static int xlnx_rtc_probe(struct platform_device *pdev)
<br>&gt; +{
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 struct xlnx_rtc_dev *xrtcdev;
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 struct resource *res;
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 int ret;
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 unsigned int calibvalue;
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 xrtcdev =3D devm_kzalloc(&amp;pdev-&gt;dev,=
 sizeof(*xrtcdev), GFP_KERNEL);
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 if (!xrtcdev)
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 platform_set_drvdata(pdev, xrtcdev);
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 res =3D platform_get_resource(pdev, IORESOU=
RCE_MEM, 0);
<br>Do you want to check for return value here?
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 xrtcdev-&gt;reg_base =3D devm_ioremap_resou=
rce(&amp;pdev-&gt;<wbr>dev, res);
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(xrtcdev-&gt;reg_base))
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return PTR_ERR(=
xrtcdev-&gt;reg_base);
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 xrtcdev-&gt;alarm_irq =3D platform_get_irq_=
byname(pdev, &quot;alarm&quot;);
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 if (xrtcdev-&gt;alarm_irq &lt; 0) {
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&amp;pd=
ev-&gt;dev, &quot;no irq resource\n&quot;);
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return xrtcdev-=
&gt;alarm_irq;
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 }
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 ret =3D devm_request_irq(&amp;pdev-&gt;dev,=
 xrtcdev-&gt;alarm_irq,
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xlnx_rtc_interrupt, 0,
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_name(&amp;pdev-&gt;dev), xrtcd=
ev);
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 if (ret) {
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&amp;pd=
ev-&gt;dev, &quot;request irq failed\n&quot;);
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 }
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 xrtcdev-&gt;sec_irq =3D platform_get_irq_by=
name(pdev, &quot;sec&quot;);
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 if (xrtcdev-&gt;sec_irq &lt; 0) {
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&amp;pd=
ev-&gt;dev, &quot;no irq resource\n&quot;);
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return xrtcdev-=
&gt;sec_irq;
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 }
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 ret =3D devm_request_irq(&amp;pdev-&gt;dev,=
 xrtcdev-&gt;sec_irq,
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xlnx_rtc_interrupt, 0,
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_name(&amp;pdev-&gt;dev), xrtcd=
ev);
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 if (ret) {
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_err(&amp;pd=
ev-&gt;dev, &quot;request irq failed\n&quot;);
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 }
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 ret =3D of_property_read_u32(pdev-&gt;<wbr>=
dev.of_node, &quot;calibration&quot;,
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;calibvalue);
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 if (ret)
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 calibvalue =3D =
RTC_CALIB_DEF;
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 xlnx_init_rtc(xrtcdev, calibvalue);
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 device_init_wakeup(&amp;pdev-&gt;dev, 1);
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 xrtcdev-&gt;rtc =3D devm_rtc_device_registe=
r(&amp;<wbr>pdev-&gt;dev, pdev-&gt;name,
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0&amp;xlnx_rtc_ops, THIS_MODULE);
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 return PTR_ERR_OR_ZERO(xrtcdev-&gt;rtc);
<br>&gt; +}
<br>&gt; +
<br>&gt; +static int xlnx_rtc_remove(struct platform_device *pdev)
<br>&gt; +{
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 xlnx_rtc_alarm_irq_enable(&amp;<wbr>pdev-&g=
t;dev, 0);
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 device_init_wakeup(&amp;pdev-&gt;dev, 0);
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 return 0;
<br>&gt; +}
<br>&gt; +
<br>&gt; +static int __maybe_unused xlnx_rtc_suspend(struct device *dev)
<br>&gt; +{
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 struct platform_device *pdev =3D to_platfor=
m_device(dev);
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 struct xlnx_rtc_dev *xrtcdev =3D platform_g=
et_drvdata(pdev);
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 if (device_may_wakeup(&amp;pdev-&gt;dev)<wb=
r>)
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enable_irq_wake=
(xrtcdev-&gt;<wbr>alarm_irq);
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 else
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xlnx_rtc_alarm_=
irq_enable(dev, 0);
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 return 0;
<br>&gt; +}
<br>&gt; +
<br>&gt; +static int __maybe_unused xlnx_rtc_resume(struct device *dev)
<br>&gt; +{
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 struct platform_device *pdev =3D to_platfor=
m_device(dev);
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 struct xlnx_rtc_dev *xrtcdev =3D platform_g=
et_drvdata(pdev);
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 if (device_may_wakeup(&amp;pdev-&gt;dev)<wb=
r>)
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 disable_irq_wak=
e(xrtcdev-&gt;<wbr>alarm_irq);
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 else
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 xlnx_rtc_alarm_=
irq_enable(dev, 1);
<br>&gt; +
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 return 0;
<br>&gt; +}
<br>&gt; +
<br>&gt; +static SIMPLE_DEV_PM_OPS(xlnx_rtc_pm_<wbr>ops, xlnx_rtc_suspend, =
xlnx_rtc_resume);
<br>&gt; +
<br>&gt; +static const struct of_device_id xlnx_rtc_of_match[] =3D {
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 {.compatible =3D &quot;xlnx,zynqmp-rtc&quot=
; },
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 { }
<br>&gt; +};
<br>&gt; +MODULE_DEVICE_TABLE(of, xlnx_rtc_of_match);
<br>&gt; +
<br>&gt; +static struct platform_driver xlnx_rtc_driver =3D {
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 .probe =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D xlnx_rtc_probe,
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 .remove =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D xln=
x_rtc_remove,
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 .driver =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D {
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =C2=A0 =
=3D KBUILD_MODNAME,
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .pm =C2=A0 =C2=
=A0 =3D &amp;xlnx_rtc_pm_ops,
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .of_match_table=
 =3D xlnx_rtc_of_match,
<br>&gt; + =C2=A0 =C2=A0 =C2=A0 },
<br>&gt; +};
<br>&gt; +
<br>&gt; +module_platform_driver(xlnx_<wbr>rtc_driver);
<br>&gt; +
<br>&gt; +MODULE_DESCRIPTION(&quot;Xilinx Zynq MPSoC RTC driver&quot;);
<br>&gt; +MODULE_AUTHOR(&quot;Xilinx Inc.&quot;);
<br>&gt; +MODULE_LICENSE(&quot;GPL v2&quot;);
<br>&gt; --
<br>&gt; 2.1.2
<br>&gt;
<br>&gt;
<br>&gt; ______________________________<wbr>_________________
<br>&gt; linux-arm-kernel mailing list
<br>&gt; <a href=3D"javascript:" target=3D"_blank" gdf-obfuscated-mailto=3D=
"ScWhbjoKBQAJ" rel=3D"nofollow" onmousedown=3D"this.href=3D&#39;javascript:=
&#39;;return true;" onclick=3D"this.href=3D&#39;javascript:&#39;;return tru=
e;">linux-ar...@lists.<wbr>infradead.org</a>
<br>&gt; <a href=3D"http://lists.infradead.org/mailman/listinfo/linux-arm-k=
ernel" target=3D"_blank" rel=3D"nofollow" onmousedown=3D"this.href=3D&#39;h=
ttp://www.google.com/url?q\75http%3A%2F%2Flists.infradead.org%2Fmailman%2Fl=
istinfo%2Flinux-arm-kernel\46sa\75D\46sntz\0751\46usg\75AFQjCNFVK8OeuW9xY29=
4bGsUtm4f-5lcRQ&#39;;return true;" onclick=3D"this.href=3D&#39;http://www.g=
oogle.com/url?q\75http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Fl=
inux-arm-kernel\46sa\75D\46sntz\0751\46usg\75AFQjCNFVK8OeuW9xY294bGsUtm4f-5=
lcRQ&#39;;return true;">http://lists.infradead.org/<wbr>mailman/listinfo/li=
nux-arm-<wbr>kernel</a>
<br>
<br>Cheers,
<br>
<br>Moritz
<br></blockquote></div></div>

<p></p>

-- <br />
-- <br />
You received this message because you are subscribed to &quot;rtc-linux&quo=
t;.<br />
Membership options at <a href=3D"http://groups.google.com/group/rtc-linux">=
http://groups.google.com/group/rtc-linux</a> .<br />
Please read <a href=3D"http://groups.google.com/group/rtc-linux/web/checkli=
st">http://groups.google.com/group/rtc-linux/web/checklist</a><br />
before submitting a driver.<br />
--- <br />
You received this message because you are subscribed to the Google Groups &=
quot;rtc-linux&quot; group.<br />
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:rtc-linux+unsubscribe@googlegroups.com">rtc-linux=
+unsubscribe@googlegroups.com</a>.<br />
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br />

------=_Part_6763_1261719542.1440045420919--

------=_Part_6762_319695090.1440045420918--
