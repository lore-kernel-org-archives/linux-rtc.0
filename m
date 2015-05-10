Return-Path: <rtc-linux+bncBDS7HNEFSALRBUGXXSVAKGQEGQYXK7Y@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id k2si241401wif.0.2015.05.10.02.58.39
        for <rtc-linux@googlegroups.com>;
        Sun, 10 May 2015 02:58:39 -0700 (PDT)
Date: Sun, 10 May 2015 11:58:38 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: S Twiss <stwiss.opensource@diasemi.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	LINUXKERNEL <linux-kernel@vger.kernel.org>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	DEVICETREE <devicetree@vger.kernel.org>,
	David Dajun Chen <david.chen@diasemi.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	LINUXINPUT <linux-input@vger.kernel.org>,
	LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [rtc-linux] [PATCH V1 3/6] rtc: da9062: DA9062 RTC driver
Message-ID: <20150510095838.GF3338@piout.net>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
 <860a3b6dc7f8dac95c0e36967f24551af8805f7b.1429280614.git.stwiss.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <860a3b6dc7f8dac95c0e36967f24551af8805f7b.1429280614.git.stwiss.opensource@diasemi.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 17/04/2015 at 15:23:33 +0100, S Twiss wrote :
> From: S Twiss <stwiss.opensource@diasemi.com>
> 
> Add RTC driver support for DA9062
> 
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> ---
> 
> This patch applies against linux-next and v4.0 
> 
> 
> 
>  drivers/rtc/Kconfig      |  10 ++
>  drivers/rtc/Makefile     |   1 +
>  drivers/rtc/rtc-da9062.c | 367 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 378 insertions(+)
>  create mode 100644 drivers/rtc/rtc-da9062.c
> 

This is an almost exact copy of drivers/rtc/rtc-da9063.c, apart from the
retry mechanism in read_time. Can you simply add support for the da9062
in that driver?

Thanks!

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
