Return-Path: <rtc-linux+bncBDP6N55ZUYDRB6HH3KWQKGQEXF23LZY@googlegroups.com>
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com. [2607:f8b0:400e:c03::22a])
        by gmr-mx.google.com with ESMTPS id i1si2844435pdh.0.2015.07.27.15.43.04
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2015 15:43:04 -0700 (PDT)
Received: by pachj5 with SMTP id hj5so58115957pac.3
        for <rtc-linux@googlegroups.com>; Mon, 27 Jul 2015 15:43:04 -0700 (PDT)
Date: Mon, 27 Jul 2015 15:43:00 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: S Twiss <stwiss.opensource@diasemi.com>
Cc: DEVICETREE <devicetree@vger.kernel.org>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	LINUXINPUT <linux-input@vger.kernel.org>,
	LINUXKERNEL <linux-kernel@vger.kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Pawel Moll <pawel.moll@arm.com>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	Rob Herring <robh+dt@kernel.org>,
	David Dajun Chen <david.chen@diasemi.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Support Opensource <support.opensource@diasemi.com>
Subject: [rtc-linux] Re: [PATCH V3 3/3] devicetree: da9062: Add device tree
 bindings for DA9062 OnKey
Message-ID: <20150727224300.GG3613@dtor-ws>
References: <cover.1437668261.git.stwiss.opensource@diasemi.com>
 <6bfae9b4f5475b59bddc4b71091121f1c0697a2d.1437668261.git.stwiss.opensource@diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <6bfae9b4f5475b59bddc4b71091121f1c0697a2d.1437668261.git.stwiss.opensource@diasemi.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Thu, Jul 23, 2015 at 05:17:41PM +0100, S Twiss wrote:
> From: S Twiss <stwiss.opensource@diasemi.com>
> 
> Add device tree bindings for the DA9062 OnKey driver component
> 
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> 
> ---
> Changes in V3:
>  - Child driver specifics separated out into separate document
>    in this case ../input/da9062-onkey.txt
> Changes in V2:
>  - No change
> 
> This patch applies against linux-next and next-20150708 
> 
> 
>  .../devicetree/bindings/input/da9062-onkey.txt     | 36 ++++++++++++++++++++++
>  Documentation/devicetree/bindings/mfd/da9062.txt   |  3 ++

I dropped bits for mfd/da9062.txt, changed to mention both 9062 and
9063, folded into the onkey patch and applied.

Thanks.
 
-- 
Dmitry

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
