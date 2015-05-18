Return-Path: <rtc-linux+bncBAABBCEZ46VAKGQEMCIQB2Q@googlegroups.com>
Received: from mail.melag.de (mail.melag.de. [217.6.74.107])
        by gmr-mx.google.com with ESMTPS id ec7si339646wib.3.2015.05.18.04.27.04
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2015 04:27:04 -0700 (PDT)
Message-ID: <5559CC85.5040703@melag.de>
Date: Mon, 18 May 2015 13:27:01 +0200
From: "Enrico Weigelt, metux IT consult" <weigelt@melag.de>
MIME-Version: 1.0
To: Philippe Reynes <tremyfr@gmail.com>, <shawn.guo@linaro.org>,
	<kernel@pengutronix.de>, <linux@arm.linux.org.uk>, <a.zummo@towertech.it>,
	<alexandre.belloni@free-electrons.com>, <robh+dt@kernel.org>,
	<pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<rtc-linux@googlegroups.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <fabio.estevam@freescale.com>
Subject: [rtc-linux] Re: [PATCH 1/2] rtc: mxc: add a second clock
References: <1431729330-7625-1-git-send-email-tremyfr@gmail.com> <1431729330-7625-2-git-send-email-tremyfr@gmail.com>
In-Reply-To: <1431729330-7625-2-git-send-email-tremyfr@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

Am 16.05.2015 um 00:35 schrieb Philippe Reynes:
> The mxc RTC needs two clocks, one for the input
> reference, and one for the IP. But this driver
> was only using one clock (for the reference).
> This patch add the second clock (for the IP).


Does this also apply to MX53, or just MX21 ?


greetings,
--
Enrico Weigelt, metux IT consult
+49-151-27565287
MELAG Medizintechnik oHG Sitz Berlin Registergericht AG Charlottenburg HRA =
21333 B

Wichtiger Hinweis: Diese Nachricht kann vertrauliche oder nur f=C3=BCr eine=
n begrenzten Personenkreis bestimmte Informationen enthalten. Sie ist aussc=
hlie=C3=9Flich f=C3=BCr denjenigen bestimmt, an den sie gerichtet worden is=
t. Wenn Sie nicht der Adressat dieser E-Mail sind, d=C3=BCrfen Sie diese ni=
cht kopieren, weiterleiten, weitergeben oder sie ganz oder teilweise in irg=
endeiner Weise nutzen. Sollten Sie diese E-Mail irrt=C3=BCmlich erhalten ha=
ben, so benachrichtigen Sie bitte den Absender, indem Sie auf diese Nachric=
ht antworten. Bitte l=C3=B6schen Sie in diesem Fall diese Nachricht und all=
e Anh=C3=A4nge, ohne eine Kopie zu behalten.
Important Notice: This message may contain confidential or privileged infor=
mation. It is intended only for the person it was addressed to. If you are =
not the intended recipient of this email you may not copy, forward, disclos=
e or otherwise use it or any part of it in any form whatsoever. If you rece=
ived this email in error please notify the sender by replying and delete th=
is message and any attachments without retaining a copy.

--=20
--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
