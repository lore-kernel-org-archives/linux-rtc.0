Return-Path: <rtc-linux+bncBDS7HNEFSALRBKVHZWVAKGQEV3X3Q2A@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id bc3si281251wib.2.2015.05.13.06.37.46
        for <rtc-linux@googlegroups.com>;
        Wed, 13 May 2015 06:37:46 -0700 (PDT)
Date: Wed, 13 May 2015 15:37:41 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
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
	Support Opensource <Support.Opensource@diasemi.com>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [rtc-linux] [PATCH V1 3/6] rtc: da9062: DA9062 RTC driver
Message-ID: <20150513133741.GY3338@piout.net>
References: <cover.1429280614.git.stwiss.opensource@diasemi.com>
 <860a3b6dc7f8dac95c0e36967f24551af8805f7b.1429280614.git.stwiss.opensource@diasemi.com>
 <20150510095838.GF3338@piout.net>
 <6ED8E3B22081A4459DAC7699F3695FB7014B22A3F3@SW-EX-MBX02.diasemi.com>
 <20150513125858.GX3338@piout.net>
 <55534BEF.7020409@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <55534BEF.7020409@roeck-us.net>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 13/05/2015 at 06:04:47 -0700, Guenter Roeck wrote :
> Don't know how this is handled for rtc drivers, but in other subsystems
> we just live with the original name. I don't see a need to rename a driver
> just because it starts supporting more hardware, and xxx is weird anyway
> since it suggests everything from 000 to 999, which is much worse than
> just sticking with 9063.
> 

Yes, in particular if at some point in time a new IP matching those xxx
is completely different from the previous one. I'm not fond of renaming
the driver either but if diasemi thinks that what they want, I'm open to
let it happen. But clearly, I don't want to end up in a situation like
the tlv320aic where you don't know which driver correspond to which
chip:

sound/soc/codecs/tlv320aic31xx.c
sound/soc/codecs/tlv320aic31xx.h
sound/soc/codecs/tlv320aic32x4.c
sound/soc/codecs/tlv320aic32x4.h
sound/soc/codecs/tlv320aic3x.c
sound/soc/codecs/tlv320aic3x.h
sound/soc/codecs/tlv320dac33.c
sound/soc/codecs/tlv320dac33.h

Go figure that the tlv320aic3104 can be supported by both tlv320aic3x.c
and tlv320aic32x4.c but not tlv320aic31xx.c...

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
