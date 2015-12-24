Return-Path: <rtc-linux+bncBDS7HNEFSALRBWFC56ZQKGQEUI5VZYQ@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id f18si452677wme.1.2015.12.24.03.04.56
        for <rtc-linux@googlegroups.com>;
        Thu, 24 Dec 2015 03:04:56 -0800 (PST)
Date: Thu, 24 Dec 2015 12:04:53 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Rob Herring <robh@kernel.org>
Cc: Sergei Ianovich <ynvich@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <rtc-linux@googlegroups.com>
Subject: [rtc-linux] Re: [PATCH v5] rtc: support DS1302 RTC on ICP DAS LP-8x4x
Message-ID: <20151224110453.GJ8623@piout.net>
References: <397668667-27328-3-git-send-email-ynvich@gmail.com>
 <1450201525-9137-1-git-send-email-ynvich@gmail.com>
 <20151220033815.GD9883@rob-hp-laptop>
 <1450613656.15911.62.camel@gmail.com>
 <CAL_JsqKxEkuvQ=7=zmb0pkNNyUe9aKzKics43QasUBDM2rmrwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAL_JsqKxEkuvQ=7=zmb0pkNNyUe9aKzKics43QasUBDM2rmrwA@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 22/12/2015 at 12:16:41 -0600, Rob Herring wrote :
> Well, the binding should reflect that, whether the driver needs to be
> re-written is somewhat a separate question. That should probably have
> been done for the DS1302 driver originally and it is not too fair for
> the 2nd person to fix it. You could just have a single driver bound to
> the controller node which is aware of the DS1302 being the slave
> device (ignoring that part of the DT for now).
> 

I agree with Rob here. I won't require that you fix the driver but it
would be better to have a proper DT binding from the beginning so that
when the driver is fixed it will still work with the previous device
trees.

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
