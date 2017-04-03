Return-Path: <rtc-linux+bncBDJIP47K7MERBOGORHDQKGQE6IG747Y@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com. [209.85.218.68])
        by gmr-mx.google.com with ESMTPS id f73si1187555ita.1.2017.04.03.08.16.08
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Apr 2017 08:16:08 -0700 (PDT)
Received: by mail-oi0-f68.google.com with SMTP id d2so12803791oig.2
        for <rtc-linux@googlegroups.com>; Mon, 03 Apr 2017 08:16:08 -0700 (PDT)
Date: Mon, 3 Apr 2017 10:16:06 -0500
From: Rob Herring <robh@kernel.org>
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Simon Horman <horms+renesas@verge.net.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v3 2/7] dt-bindings: rtc: document the rtc-sh bindings
Message-ID: <20170403151606.lnayy6p5lp4rmvrj@rob-hp-laptop>
References: <20170329173035.67477-1-chris.brandt@renesas.com>
 <20170329173035.67477-3-chris.brandt@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170329173035.67477-3-chris.brandt@renesas.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wed, Mar 29, 2017 at 10:30:30AM -0700, Chris Brandt wrote:
> Add the binding documentation for rtc-sh which is an RTC for
> SuperH and RZ/A SoCs.
> 
> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> ---
> v3:
> * remove 'power-domains' from example
> * update commit message subject and body
> v2:
> * added interrupt-names and clock-names
> * clocks now include counting sources
> * changed 'is a RTC' to 'is an RTC' in commit message
> ---
>  Documentation/devicetree/bindings/rtc/rtc-sh.txt | 28 ++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/rtc-sh.txt

Acked-by: Rob Herring <robh@kernel.org> 

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
