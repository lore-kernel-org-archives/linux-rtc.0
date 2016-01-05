Return-Path: <rtc-linux+bncBDS7HNEFSALRBQUSVS2AKGQEYFKCUTY@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id w129si21412wme.1.2016.01.04.16.07.30
        for <rtc-linux@googlegroups.com>;
        Mon, 04 Jan 2016 16:07:30 -0800 (PST)
Date: Tue, 5 Jan 2016 01:07:28 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, rtc-linux@googlegroups.com,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Yadwinder Singh Brar <yadi.brar01@gmail.com>
Subject: [rtc-linux] Re: [PATCH v2 1/3] rtc: s5m: Cleanup by removing useless
 'rtc' prefix from fields
Message-ID: <20160105000728.GF32724@piout.net>
References: <1451450847-928-1-git-send-email-k.kozlowski@samsung.com>
 <20160104170841.GD32724@piout.net>
 <568B0601.5020808@samsung.com>
 <568B0897.4020403@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <568B0897.4020403@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 05/01/2016 at 09:04:39 +0900, Krzysztof Kozlowski wrote :
> > 
> > Probably that's my fault because I rebased it on linux-next. I will
> > rebase the patches on rtc-next and resend.
> 
> Ah, no need for rebasing. I forgot about dependency - the support for
> S2MPS15 was added recently through Lee Jones' tree. Fortunately Lee put
> S2MPS15 patches in a separate branch and tag: "ib-mfd-regulator-rtc-4.5"
> 
> This means that to apply the patches this is needed first:
> https://git.kernel.org/cgit/linux/kernel/git/lee/mfd.git/log/?h=ib-mfd-regulator-rtc-4.5
> 

Ah, true, that's what I forgot, thanks.


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
