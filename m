Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3645208B7;
	Fri, 18 Sep 2026 19:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789759315; cv=none; b=nNJI4BwDQJ/y0+vAShlqStQf20dc2yEuThWlsgJvVk0spggqEtPGLYgZCh1FF6dqPjMEbMvLkEvDPycVCQbVkbOzPHAukK5w7zGGUroteuWXIB4/VMTysyUhr7+jhEwWF7B+y32srtDCAO7OaHeutSWpon1x4FGEKLWfpdfjMkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789759315; c=relaxed/simple;
	bh=CWAKjeA3UhyJ+EljQPmOSDhptn2gZCGiHkfx/ZJzvWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ROZOYyRIRZ/1aoT+SOg8y63287hgeS7IrjSBe/KgN1/eaN6kkRfuT1hyFWtzWdt976wUmsrUAbEYDHH0ry/PTT8C755Uv820R/SbI86E8K+u7Ednt21h++gBGy0Lah8+6PgLYsZB5meDSasRlHhDgDgVeh9ax8Omvgr0FxLEPW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kumba.dev; spf=pass smtp.mailfrom=kumba.dev; dkim=pass (2048-bit key) header.d=kumba.dev header.i=@kumba.dev header.b=Ohu7+E0X; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kr1ckQYr; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kumba.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kumba.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kumba.dev header.i=@kumba.dev header.b="Ohu7+E0X";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kr1ckQYr"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 113C7EC011F;
	Fri, 18 Sep 2026 15:21:50 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 18 Sep 2026 15:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kumba.dev; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1789759310;
	 x=1789845710; bh=+f/z0JP+U4EtOy/3h9UdmQJB7RkUpXUnEhmZ55aJB1w=; b=
	Ohu7+E0X13bssI57AEV35UM19qwkKlVHxVKz5/OJt+5uWA2bgwvwe3I65n8Jhf4H
	XLDByqkG4j8ffDCVs/Q6xYzKUa6ZT/YkddC6XEQthEIMEjXIosyRKdOol9cPjkW0
	GVWBl9QS+kojtveKPxHjj9PW4MilZbXXa46XS05slNK38qsInjQFKZg2FMWnePDl
	A3FZe2wvO4EDRwxbbsML/nBzWsfmJ0cMuhNNKW1i/h+IlVrPgcUUVLwrVbZx6b5b
	zZVHADvusGbai2aK8rsNU3PGynlPKv8S1H9/t09am0oBZh5swBsqCKlZ8SGQO7+2
	XBPWq+3T1OZp13yyfz4pqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789759310; x=
	1789845710; bh=+f/z0JP+U4EtOy/3h9UdmQJB7RkUpXUnEhmZ55aJB1w=; b=K
	r1ckQYrv3A14SBmzHUCbHcRHG+KEhtOeOtoMjBTC8ne+iBRnbL4+9+K5ap5YeO8j
	o/fol20VTErYRDRisbqjD+ll6e1wb40zlKq3vt2BWX+5nWnI1kMqFUXXzyXRrxSG
	FPE1Sbsfx1LGe+gExUOUcieKNDliLJE6zQefD7TGMyHm/6Mgl2Fg5KPtqq9IBEJ4
	JKm3V1NyFS5gNeuJo1x0Yw6cU0A7mEy14Zu2rT8bg1/Q75DqPhBBXxsdUknnzIQU
	J63jJ9wvl6eeLU6oQCwoc1EbnEDXin/yGS7uXopJ5I0pw3NVkybUX9nS+Dby1et8
	tEmRHbdM/DKb5ime9EeTw==
X-ME-Sender: <xms:TY-takZVLWMmtCpYhAQ3_6ZGp5fO9istKWENaeAQpssek2wJNCtRtw>
    <xme:TY-tanlD5AcIn-tdu0_0iK8re9JAWHeyTVHplTp_TiRzh8I_I_k5ug03Hc8Mng4l8
    mYAc6sTIbQeEQXp6_xJeAt2x6cku5s41YBtwE5g2_ul0EAUI7j1U1zE>
X-ME-Received: <xmr:TY-taqgy1hsAGPCnB-K3cyoyrCABuJ8xH7xb4x3i31tmVH3BAjUgbg80bKajcooU0JJsnmP-UX0rnugrhtZM2iX4kOg5v4tAIQMLHydhZqQl5o8>
X-ME-Proxy-Cause: dmFkZTEsnz2aMme9OvfQGG5Y8GSqHa68DLZlnr4e8JXNRIraPpfK2AhpuQYaQCdLuH4d4E
    LCf7BP7IA/lS6ef53ADgoMj+JJ/mfoIxRWkwLbNogOo65dFObknUvCBwx3CuljCtfTjYt5
    u8IgnSBS9MIdBJMYMpSU/2MI1Ww4O+I1oZuH5uDhV+KS5+9j2MZtNCFl8UITbzpMHz6hTx
    WzNUI4GZ1f2aO6SUmft1nX6DFK0J3tXJBGRZ4ohV661vDuOQcfX53XrGmz+XUAmSLgNImo
    TrAj3oMzAniMrTHGv2RdwVs4cQhQXPQQnkWU+5lZA5CRqlCfrOtrKugQ6Czie/gtclxKD8
    8rCP1K1Oo295ye6IuknLXJz1K/9UvCX5a810NWifNAJj+yurGPJEHYnpxeSOJGdFMXUxpb
    ZytZ2qLoMQaDQmUM+ymJHefuhzMvLzSspTnlPXRp/4LWi+9btixsrf33AsUTSZAdqUSmag
    OQwv1XbeAFsqLjbamfIsE3Azyfr64SvJrmRkVvE/Xan0gCN60uC+eAOwoXV1xyrRjCHFcv
    qnWEU87JqoV8Rp7+EzTjfxXqQEMX7CZxTCblmv49QPBahF/oz8T/VjEliwx7Ieh1t4F2x9
    YP/g6ppWTbIgI2vFYObaMJ5WXLoyJCMyeMdxZGv7xik33Mv5KnCFg1za4wqQ
X-ME-Proxy: <xmx:TY-tapQHDxEi6e7ZtWDdsVH1sBd4vGJpqgRHDJowfKqzhy1cAaBPyQ>
    <xmx:TY-tarZ18w-SrJXRqbH8Lj9ezP2RFuzVHePc-gMghlMoqJBuzgQgig>
    <xmx:TY-tamR1F9UYLt1Lxh_23KhO1spvkajFI5M-KhZjmmibFzU4npXRDg>
    <xmx:TY-taq_ub46dhJx8_55xxaTJxPT5nq2DesWDiSk6-dB1hPvt1yJwAA>
    <xmx:To-taqhcKck-bj2gDgjmyLIOWtaag69IjTaZXEJs5PhQYsLZefvKSQys>
Feedback-ID: if8114916:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Sep 2026 15:21:49 -0400 (EDT)
Message-ID: <c4a61df3-6786-446c-96cf-ebff064b9c46@kumba.dev>
Date: Fri, 18 Sep 2026 15:21:48 -0400
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtc: fix typos in comments
To: Hemanth Selam <hemanth.selam@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
References: <20260904104758.23905-1-hemanth.selam@gmail.com>
Content-Language: en-US
From: Joshua Kinard <linux@kumba.dev>
In-Reply-To: <20260904104758.23905-1-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/04/2026 06:47, Hemanth Selam wrote:
> Fix typos in comments, reported by scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Only touches comments, no code
> changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>   drivers/rtc/rtc-ds1685.c   | 6 +++---
>   drivers/rtc/rtc-meson.c    | 2 +-
>   drivers/rtc/rtc-pcf8583.c  | 2 +-
>   drivers/rtc/rtc-rk808.c    | 2 +-
>   drivers/rtc/rtc-sa1100.c   | 2 +-
>   drivers/rtc/rtc-spear.c    | 2 +-
>   include/linux/rtc/ds1685.h | 4 ++--
>   7 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
> index 5fc8e36b1abf..beb987b76f24 100644
> --- a/drivers/rtc/rtc-ds1685.c
> +++ b/drivers/rtc/rtc-ds1685.c
> @@ -1231,7 +1231,7 @@ ds1685_rtc_probe(struct platform_device *pdev)
>   		dev_warn(&pdev->dev,
>   			 "Main battery is exhausted! RTC may be invalid!\n");
>   
> -	/* Check the auxillary battery.  It is optional. */
> +	/* Check the auxiliary battery.  It is optional. */
>   	if (!(rtc->read(rtc, RTC_EXT_CTRL_4A) & RTC_CTRL_4A_VRT2))
>   		dev_warn(&pdev->dev,
>   			 "Aux battery is exhausted or not available.\n");
> @@ -1395,7 +1395,7 @@ ds1685_rtc_poweroff(struct platform_device *pdev)
>   		rtc->write(rtc, RTC_CTRL_A, ctrla);
>   
>   		/*
> -		 * Read Control 4A and check the status of the auxillary
> +		 * Read Control 4A and check the status of the auxiliary
>   		 * battery.  This must be present and working (VRT2 = 1)
>   		 * for wakeup and kickstart functionality to be useful.
>   		 */
> @@ -1407,7 +1407,7 @@ ds1685_rtc_poweroff(struct platform_device *pdev)
>   			rtc->write(rtc, RTC_EXT_CTRL_4A, ctrl4a);
>   
>   			/*
> -			 * The auxillary battery is present and working.
> +			 * The auxiliary battery is present and working.
>   			 * Enable extended functions (ABE=1), enable
>   			 * wake-up (WIE=1), and enable kickstart (KSE=1)
>   			 * in Control 4B.
> diff --git a/include/linux/rtc/ds1685.h b/include/linux/rtc/ds1685.h
> index 8ec0ebfaef04..55d3edc7e972 100644
> --- a/include/linux/rtc/ds1685.h
> +++ b/include/linux/rtc/ds1685.h
> @@ -200,7 +200,7 @@ struct ds1685_rtc_platform_data {
>    * access to the extended NV-SRAM by automatically incrementing the address
>    * register when they are read from or written to.
>    */
> -#define RTC_CTRL_4A_VRT2	BIT(7)	/* Auxillary Battery Status */
> +#define RTC_CTRL_4A_VRT2	BIT(7)	/* Auxiliary Battery Status */
>   #define RTC_CTRL_4A_INCR	BIT(6)	/* Increment-in-Progress Status */
>   #define RTC_CTRL_4A_PAB		BIT(3)	/* Power-Active Bar Control */
>   #define RTC_CTRL_4A_RF		BIT(2)	/* RAM-Clear Flag */
> @@ -215,7 +215,7 @@ struct ds1685_rtc_platform_data {
>   /*
>    * Bit names in Extended Control Register 4B.
>    */
> -#define RTC_CTRL_4B_ABE		BIT(7)	/* Auxillary Battery Enable */
> +#define RTC_CTRL_4B_ABE		BIT(7)	/* Auxiliary Battery Enable */
>   #define RTC_CTRL_4B_E32K	BIT(6)	/* Enable 32.768Hz on SQW Pin */
>   #define RTC_CTRL_4B_CS		BIT(5)	/* Crystal Select */
>   #define RTC_CTRL_4B_RCE		BIT(4)	/* RAM Clear-Enable */

Huh, I am honestly now wondering how I made such simple typos all those 
years ago, and why it took an AI agent to find them.  At least I was 
consistent in making them, so that's gotta amount to something.

Thanks!

Acked-by: Joshua Kinard <linux@kumba.dev>
