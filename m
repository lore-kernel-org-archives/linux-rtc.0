Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6760A3D9DA1;
	Tue, 25 Aug 2026 13:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787664512; cv=none; b=QzWcsRh4lfyfL89W3Wv0vl73yYn7eXYvMqdXAVupGkZBYca/VKTdlkcIARxT8+mWukjD44W4fk3eloRjA779Xn9w4Kl6BDxRB6xXR2KNw9RBydIEuIXcJD+ETgYiK0sNJDSdG9/plmW0nEK8qrHyGyeIDB2q8WIDks1/ecVMoKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787664512; c=relaxed/simple;
	bh=nXIDNeK0qAmNjsxIPbmvFt4k7Hi+Qik1VeWnEs/PdRg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=u8c6g9RCpv+rKFGBZ7WM+PVW7Z0npJIW1Omd0A62lBhRJd0pZw6wz6hBxbBy8lVv6L6qjv0l26MN9xBHrHyHhQEmkJbDBPmBr42UN0HhIS81k3jjgTp3agOn3NKTlP+3YcLyoEXjxRMxSzgvo9nnuwEKZMI1Vmzlahj4KDegSfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=DfX4JL+G; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="DfX4JL+G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=default; h=Content-Transfer-Encoding:Mime-Version:Message-Id:Subject:Cc:
	To:From:Date:subject:date:message-id:reply-to;
	bh=sYd2yF5EIMwqbxFouj8U9wGNvbFGrupAqlCE3ROY62Q=; b=DfX4JL+Gt7ImZPvxdBD/ZLXJak
	ZxGqdXdX7vHV/yE4DvXY5DeeEJu9Ew07W8dcDgcDWJ5SraL07tUUvDlLt5dWlcrp2gtxmgGsns2q4
	DEgYjQdZwm9CVjkZ+nywHe1h773EOy8tJ8N3qaiIv/IK2yq1MZMQyYdRjJDyG7c1DW3s=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61] helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.98.2)
	(envelope-from <hugo@hugovil.com>)
	id 1wyqkL-000000006II-2faw;
	Tue, 25 Aug 2026 08:59:22 -0400
Date: Tue, 25 Aug 2026 08:59:11 -0400
From: Hugo Villeneuve <hugo@hugovil.com>
To: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Cc: alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org,
 linux-kernel@vger.kernel.org, bruno.thomsen@gmail.com,
 giampiero@sferalabs.cc, p.rosenberger@kunbus.com, antonio@amsobr.com, Hugo
 Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH 0/4] rtc: pcf2127: add support for battery low voltage
 detection
Message-Id: <20260825085911.ba47297a8cb56028441114e8@hugovil.com>
In-Reply-To: <84b6915f-328f-49b4-8466-1ea27a839cf3@pengutronix.de>
References: <20260311200237.3531981-1-hugo@hugovil.com>
	<84b6915f-328f-49b4-8466-1ea27a839cf3@pengutronix.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam_score: -2.0
X-Spam_bar: --

Hi Stefan,

On Wed, 29 Jul 2026 17:18:59 +0200
Stefan Kerkmann <s.kerkmann@pengutronix.de> wrote:

> Hello Hugo,
> 
> On 3/11/26 21:02, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Hello,
> > this patch series adds support for battery low voltage detection configuration
> > for RTC devicesm, with specifc changes targeted at the pcf2127/2131 devices.
> > 
> > The origin of this patch goes back to the initial commit to add support for the
> > PCF2131 device. On the PCF2131, the battery low voltage detection is disabled by
> > default at the hardware level, contrary to the PCF2127 where it is enabled by
> > default. Because of that, a lot of people are stuck with a PCF2131 RTC device
> > using a battery backup, but unable to use it!
> > 
> > A lot of people are writing to me in private emails to report this as a bug
> > in the PCF2131 driver. Others (and me) have proposed to implement device tree
> > properties to enable these functions, but this was rejected [1][2][3].
> > 
> > It is important to note that some projects do not have the luxury to modify
> > the bootloder to enable that function at boot, and for these having a DT
> > property that could be put in a DT overlay would simplify a lot their life.
> > Also having to rely on a userspace application to configure the RTC is also
> > not ideal, as some projects use stock Debian distros (for example), and
> > adding a new application to their repository is not trivial or easy.
> > 
> > So as the next best thing, this patch aims to add what is missing in the driver,
> > the ability to enable/disable the battery low voltage detection with ioctls,
> > similarly to what is done with the BSM.
> > 
> 
> Thank you for the series. We have customer that has this exact use case:

Ok, a lot of people affected by this...

> 
> Enabling the backup battery switch-over and low battery detection on a pcf2131 
> rtc. With util-linux's hwclock the former can already be enabled e.g. hwclock 
> --param-set bsm <xyz> and for the later this patch series would enable it as well.
> 
> > This patch has been tested on a custom board with a PCF2131 and using my
> > userspace application:
> > 
> >      git clone -b batlow_param git@git.hugovil.com:repos/hvrtc.git
> > 
> 
> If this series gets merged I can sent a PR to util-linux to enable the low 
> battery detection via hwclock as well.

Good.

Unfortunately, I haven't received any feedback from the RTC
maintainer(s) about this series, nor have I received any answers
to my previous inquiries about this problem.

I send patches to other kernel subsystem, and eventually I always
receive feedback, but RTC seems to be in a
different category. I sometimes wonder if there is still an
active RTC maintainer...

Hugo.


> > Thank you.
> > 
> > Link: https://lore.kernel.org/linux-rtc/20190910143945.9364-1-bruno.thomsen@gmail.com/ [1]
> > Link: https://lore.kernel.org/linux-rtc/20191211163354.GC1463890@piout.net/ [2]
> > Link: https://lore.kernel.org/linux-rtc/20230123170731.6064430c50f5fb7b484d8734@hugovil.com/ [3]
> > 
> > Hugo Villeneuve (4):
> >    rtc: pcf2127: remove redundant break statement in switch-case
> >    rtc: pcf2127: add pcf2127_pwrmng_get/set
> >    rtc: add battery low voltage detection feature
> >    rtc: pcf2127: support battery low voltage detection function
> > 
> >   drivers/rtc/rtc-pcf2127.c | 94 ++++++++++++++++++++++++++++++---------
> >   include/uapi/linux/rtc.h  |  7 ++-
> >   2 files changed, 80 insertions(+), 21 deletions(-)
> > 
> > 
> > base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> 
> Best regards,
> Stefan
> 
> -- 
> Pengutronix e.K.                       | Stefan Kerkmann             |
> Steuerwalder Str. 21                   | https://www.pengutronix.de/ |
> 31137 Hildesheim, Germany              | Phone: +49-5121-206917-128  |
> Amtsgericht Hildesheim, HRA 2686       | Fax:   +49-5121-206917-9    |

-- 
Hugo Villeneuve
