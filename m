Return-Path: <rtc-linux+bncBAABB7ML3KXAKGQEXPSIJYY@googlegroups.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com (mail-bn1on0134.outbound.protection.outlook.com. [157.56.110.134])
        by gmr-mx.google.com with ESMTPS id g144si657355ywb.6.2015.08.20.18.59.25
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Aug 2015 18:59:25 -0700 (PDT)
From: Wang Dongsheng <Dongsheng.Wang@freescale.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>, "Krzysztof
 Kozlowski" <k.kozlowski@samsung.com>
CC: "a.zummo@towertech.it" <a.zummo@towertech.it>,
	"rtc-linux@googlegroups.com" <rtc-linux@googlegroups.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [rtc-linux] RE: [PATCH v2] rtc/ds3232: fix ds3232 get a WARNING trace
 in resume function
Date: Fri, 21 Aug 2015 01:59:23 +0000
Message-ID: <SN1PR0301MB1616BF2DDDC7F09120D448DE9D650@SN1PR0301MB1616.namprd03.prod.outlook.com>
References: <1439370853-32282-1-git-send-email-dongsheng.wang@freescale.com>
 <20150820232206.GF3769@piout.net>
In-Reply-To: <20150820232206.GF3769@piout.net>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Thanks, I will push v3 to fix them.

Regards,
-Dongsheng

> -----Original Message-----
> From: Alexandre Belloni [mailto:alexandre.belloni@free-electrons.com]
> Sent: Friday, August 21, 2015 7:22 AM
> To: Wang Dongsheng-B40534; Krzysztof Kozlowski
> Cc: a.zummo@towertech.it; rtc-linux@googlegroups.com; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v2] rtc/ds3232: fix ds3232 get a WARNING trace in resume
> function
> 
> On 12/08/2015 at 17:14:13 +0800, Dongsheng Wang wrote :
> > From: Wang Dongsheng <dongsheng.wang@freescale.com>
> >
> > If ds3232 work on some platform that is not implementation
> > irq_set_wake, ds3232 will get a WARNING trace in resume.
> > So fix ds3232->suspended state to false when irq_set_irq_wake return
> > error.
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 729 at kernel/irq/manage.c:604
> > irq_set_irq_wake+0x4b/0x8c()
> > Unbalanced IRQ 201 wake disable
> > Modules linked in:
> > CPU: 0 PID: 729 Comm: sh Not tainted 3.12.19-rt30+ #25 [<800107d9>]
> > (unwind_backtrace+0x1/0x88) from [<8000e4ef>]
> > (show_stack+0xb/0xc)
> > [<8000e4ef>] (show_stack+0xb/0xc) from [<802b5fa9>]
> > (dump_stack+0x4d/0x60)
> > [<802b5fa9>] (dump_stack+0x4d/0x60) from [<800186dd>]
> > (warn_slowpath_common+0x45/0x64)
> > [<800186dd>] (warn_slowpath_common+0x45/0x64) from [<80018717>]
> > (warn_slowpath_fmt+0x1b/0x24)
> > [<80018717>] (warn_slowpath_fmt+0x1b/0x24) from [<8003a8d3>]
> > (irq_set_irq_wake+0x4b/0x8c)
> > [<8003a8d3>] (irq_set_irq_wake+0x4b/0x8c) from [<80204fcb>]
> > (ds3232_resume+0x2d/0x36)
> > [<80204fcb>] (ds3232_resume+0x2d/0x36) from [<801954c7>]
> > (dpm_run_callback.isra.13+0xb/0x28)
> > [<801954c7>] (dpm_run_callback.isra.13+0xb/0x28) from [<80195b1b>]
> > (device_resume+0x7b/0xa2)
> > [<80195b1b>] (device_resume+0x7b/0xa2) from [<80195f0f>]
> > (dpm_resume+0xbb/0x19c)
> > [<80195f0f>] (dpm_resume+0xbb/0x19c) from [<801960d9>]
> > (dpm_resume_end+0x9/0x12)
> > [<801960d9>] (dpm_resume_end+0x9/0x12) from [<80037e1d>]
> > (suspend_devices_and_enter+0x17d/0x1d0)
> > [<80037e1d>] (suspend_devices_and_enter+0x17d/0x1d0) from [<80037ee1>]
> > (pm_suspend+0x71/0x128)
> > [<80037ee1>] (pm_suspend+0x71/0x128) from [<80037449>]
> > (state_store+0x6d/0x80)
> > [<80037449>] (state_store+0x6d/0x80) from [<800af4d5>]
> > (sysfs_write_file+0x9f/0xde)
> > [<800af4d5>] (sysfs_write_file+0x9f/0xde) from [<8007a437>]
> > (vfs_write+0x7b/0x104)
> > [<8007a437>] (vfs_write+0x7b/0x104) from [<8007a7f7>]
> > (SyS_write+0x27/0x48)
> > [<8007a7f7>] (SyS_write+0x27/0x48) from [<8000c121>]
> > (ret_fast_syscall+0x1/0x44)
> > ---[ end trace 640959d2e8de6ccc ]---
> >
> > Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> > ---
> > *v2*
> > - Use dev_warn_once to instead of dev_info
> >
> 
> Applied, after fixing the kernel trace and the message like suggested by
> Krzysztof.
> 
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering http://free-electrons.com

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
