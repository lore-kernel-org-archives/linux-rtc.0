Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBNNY6XFAKGQE22QRDSA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id 71si3178156wmp.3.2017.07.05.14.37.57
        for <rtc-linux@googlegroups.com>;
        Wed, 05 Jul 2017 14:37:57 -0700 (PDT)
Date: Wed, 5 Jul 2017 23:37:46 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Amelie Delaunay <amelie.delaunay@st.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	rtc-linux@googlegroups.com, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 2/2] rtc: stm32: add STM32H7 RTC support
Message-ID: <20170705213746.6hf5af57ty6wsfgs@piout.net>
References: <1498470689-26829-1-git-send-email-amelie.delaunay@st.com>
 <1498470689-26829-3-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <1498470689-26829-3-git-send-email-amelie.delaunay@st.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

This is mostly fine, even if I'm not too happy with the
s/ck_rtc/rtc_ck/.

On 26/06/2017 at 11:51:29 +0200, Amelie Delaunay wrote:
> -	rtc->ck_rtc = devm_clk_get(&pdev->dev, NULL);
> -	if (IS_ERR(rtc->ck_rtc)) {
> -		dev_err(&pdev->dev, "no ck_rtc clock");
> -		return PTR_ERR(rtc->ck_rtc);
> +	match = of_match_device(stm32_rtc_of_match, &pdev->dev);
> +	if (match && match->data)
> +		rtc->data = (struct stm32_rtc_data *)match->data;
> +	else
> +		return -EINVAL;

This will never happen, you can remove that test.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
