Return-Path: <rtc-linux+bncBDJIP47K7MERBEVU265QKGQE4H3GJOI@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-qk0-f195.google.com (mail-qk0-f195.google.com. [209.85.220.195])
        by gmr-mx.google.com with ESMTPS id u136si66906ywc.7.2016.06.30.19.48.50
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jun 2016 19:48:50 -0700 (PDT)
Received: by mail-qk0-f195.google.com with SMTP id j2so20787614qkf.1
        for <rtc-linux@googlegroups.com>; Thu, 30 Jun 2016 19:48:50 -0700 (PDT)
Date: Thu, 30 Jun 2016 21:48:47 -0500
From: Rob Herring <robh@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Lee Jones <lee.jones@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@codeaurora.org>,
	linux-arm-kernel@lists.infradead.org, rtc-linux@googlegroups.com,
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH v4 1/7] mfd: ac100: Add device tree bindings
 for X-Powers AC100 codec/RTC combo IC
Message-ID: <20160701024847.GA1444@rob-hp-laptop>
References: <1467302331-9663-1-git-send-email-wens@csie.org>
 <1467302331-9663-2-git-send-email-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1467302331-9663-2-git-send-email-wens@csie.org>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Thu, Jun 30, 2016 at 11:58:45PM +0800, Chen-Yu Tsai wrote:
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes since v3:
> 
>   - Fixed device node names and added labels.
>   - Added clock output from codec and input to rtc.
> 
> Changes since v2:
> 
>   - Fix interrupt line for ac100_codec in provided example.
> 
> ---
>  Documentation/devicetree/bindings/mfd/ac100.txt | 49 +++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ac100.txt

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
