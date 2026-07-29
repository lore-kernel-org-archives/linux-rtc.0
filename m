Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B54477E37;
	Wed, 29 Jul 2026 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338353; cv=none; b=Rc8915P/EdTeBJXK4P5wnnkncxldg0i8wP1mLUEFAavfL9p25NR7Vccsi38BPzmUBPCJtp6fb/UJckPjpZ8E6D/oU1vOEIlQctCK4nqNQUqxX9ls3sbAqxxcnBsHuRMexXFfPbP7fBHUwdKPvOclnJSt/flcFs6kFZlz1QFtyVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338353; c=relaxed/simple;
	bh=wdG/QuiF0F1aohE/BcpMiBjHXxPDfEu/iLNid2wvN2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZlkDrYotEJ4A6X+ewMMgkzgGTdHZWOCrDLmVKMu9nFk5/nnCPzcs3VUNIfoalt1O3Gh/K+DukcivmMC3WhfMOviriWsVt5y1lXh4ec5w51Qh2VA0fc9pJqtGAz78MwHpRyCSy8A1t91JaPxFgMWuXtqolOkF0r2ZSfXYERGUx1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id B5397201C96;
	Wed, 29 Jul 2026 17:19:00 +0200 (CEST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPV6:::1])
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1wp63g-001u5h-1r;
	Wed, 29 Jul 2026 17:19:00 +0200
Message-ID: <84b6915f-328f-49b4-8466-1ea27a839cf3@pengutronix.de>
Date: Wed, 29 Jul 2026 17:18:59 +0200
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] rtc: pcf2127: add support for battery low voltage
 detection
To: Hugo Villeneuve <hugo@hugovil.com>, alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
 bruno.thomsen@gmail.com, giampiero@sferalabs.cc, p.rosenberger@kunbus.com,
 antonio@amsobr.com, Hugo Villeneuve <hvilleneuve@dimonoff.com>
References: <20260311200237.3531981-1-hugo@hugovil.com>
From: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Content-Language: en-US, de-DE
In-Reply-To: <20260311200237.3531981-1-hugo@hugovil.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Hugo,

On 3/11/26 21:02, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Hello,
> this patch series adds support for battery low voltage detection configuration
> for RTC devicesm, with specifc changes targeted at the pcf2127/2131 devices.
> 
> The origin of this patch goes back to the initial commit to add support for the
> PCF2131 device. On the PCF2131, the battery low voltage detection is disabled by
> default at the hardware level, contrary to the PCF2127 where it is enabled by
> default. Because of that, a lot of people are stuck with a PCF2131 RTC device
> using a battery backup, but unable to use it!
> 
> A lot of people are writing to me in private emails to report this as a bug
> in the PCF2131 driver. Others (and me) have proposed to implement device tree
> properties to enable these functions, but this was rejected [1][2][3].
> 
> It is important to note that some projects do not have the luxury to modify
> the bootloder to enable that function at boot, and for these having a DT
> property that could be put in a DT overlay would simplify a lot their life.
> Also having to rely on a userspace application to configure the RTC is also
> not ideal, as some projects use stock Debian distros (for example), and
> adding a new application to their repository is not trivial or easy.
> 
> So as the next best thing, this patch aims to add what is missing in the driver,
> the ability to enable/disable the battery low voltage detection with ioctls,
> similarly to what is done with the BSM.
> 

Thank you for the series. We have customer that has this exact use case:

Enabling the backup battery switch-over and low battery detection on a pcf2131 
rtc. With util-linux's hwclock the former can already be enabled e.g. hwclock 
--param-set bsm <xyz> and for the later this patch series would enable it as well.

> This patch has been tested on a custom board with a PCF2131 and using my
> userspace application:
> 
>      git clone -b batlow_param git@git.hugovil.com:repos/hvrtc.git
> 

If this series gets merged I can sent a PR to util-linux to enable the low 
battery detection via hwclock as well.

> Thank you.
> 
> Link: https://lore.kernel.org/linux-rtc/20190910143945.9364-1-bruno.thomsen@gmail.com/ [1]
> Link: https://lore.kernel.org/linux-rtc/20191211163354.GC1463890@piout.net/ [2]
> Link: https://lore.kernel.org/linux-rtc/20230123170731.6064430c50f5fb7b484d8734@hugovil.com/ [3]
> 
> Hugo Villeneuve (4):
>    rtc: pcf2127: remove redundant break statement in switch-case
>    rtc: pcf2127: add pcf2127_pwrmng_get/set
>    rtc: add battery low voltage detection feature
>    rtc: pcf2127: support battery low voltage detection function
> 
>   drivers/rtc/rtc-pcf2127.c | 94 ++++++++++++++++++++++++++++++---------
>   include/uapi/linux/rtc.h  |  7 ++-
>   2 files changed, 80 insertions(+), 21 deletions(-)
> 
> 
> base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f

Best regards,
Stefan

-- 
Pengutronix e.K.                       | Stefan Kerkmann             |
Steuerwalder Str. 21                   | https://www.pengutronix.de/ |
31137 Hildesheim, Germany              | Phone: +49-5121-206917-128  |
Amtsgericht Hildesheim, HRA 2686       | Fax:   +49-5121-206917-9    |

