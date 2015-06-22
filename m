Return-Path: <rtc-linux+bncBDS7HNEFSALRBB6DUGWAKGQES7ORXWI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id gt9si914650wib.2.2015.06.22.12.27.03
        for <rtc-linux@googlegroups.com>;
        Mon, 22 Jun 2015 12:27:03 -0700 (PDT)
Date: Mon, 22 Jun 2015 21:27:02 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Rob Herring <robherring2@gmail.com>
Cc: Philippe Reynes <tremyfr@gmail.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Shawn Guo <shawn.guo@linaro.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	rtc-linux@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [rtc-linux] Re: [PATCH v3 5/6] dt-binding: document the binding for
 mxc rtc
Message-ID: <20150622192702.GC19203@piout.net>
References: <1434820360-21935-1-git-send-email-tremyfr@gmail.com>
 <1434820360-21935-6-git-send-email-tremyfr@gmail.com>
 <CAL_JsqKQzC=aSuORGhsuPQ0Ciha2JVpYOGU91M2iHaG8RousnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CAL_JsqKQzC=aSuORGhsuPQ0Ciha2JVpYOGU91M2iHaG8RousnQ@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 22/06/2015 at 08:59:06 -0500, Rob Herring wrote :
> What about newer versions with the secure functionality. IIRC, that
> was in MX31 and later.
> 

Aren't those covered by the snvs driver?


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
