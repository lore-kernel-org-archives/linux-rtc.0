Return-Path: <rtc-linux+bncBDS7HNEFSALRBCGGWWWQKGQETN2PPMQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id v8si441385wiw.1.2015.07.20.14.07.20
        for <rtc-linux@googlegroups.com>;
        Mon, 20 Jul 2015 14:07:20 -0700 (PDT)
Date: Mon, 20 Jul 2015 23:07:17 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	LINUXINPUT <linux-input@vger.kernel.org>,
	LINUXKERNEL <linux-kernel@vger.kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	Rob Herring <robh+dt@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	David Dajun Chen <david.chen@diasemi.com>,
	Lee Jones <lee.jones@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Support Opensource <Support.Opensource@diasemi.com>
Subject: [rtc-linux] Re: [PATCH RFC V1 3/3] devicetree: da9062: Add device
 tree bindings for DA9062 RTC
Message-ID: <20150720210717.GN15539@piout.net>
References: <cover.1436427954.git.stwiss.opensource@diasemi.com>
 <b47f52abd6a574e5f95760a07a59f445031baefc.1436427954.git.stwiss.opensource@diasemi.com>
 <20150717234737.GJ3487@piout.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B253DAD@SW-EX-MBX02.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7014B253DAD@SW-EX-MBX02.diasemi.com>
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

On 20/07/2015 at 17:08:00 +0000, Opensource [Steve Twiss] wrote :
> If I miss out the compatible line for the RTC in the DTSI for DA9062, or is I alter it
> so it does not match the string specified in the DA9063 RTC driver, the DA9063 RTC
> driver will not be probed for the DA9062 compatibility.
> The RTC compatible = "dlg,da9062-rtc"  is essential in this case.
> 

You are right. Disregard my comment.

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
