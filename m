Return-Path: <rtc-linux+bncBD5O5IWPJMIMTQHJVICRUBBD6U53M@googlegroups.com>
Received: from mail-wg0-x232.google.com (mail-wg0-x232.google.com. [2a00:1450:400c:c00::232])
        by gmr-mx.google.com with ESMTPS id p12si442661wiv.1.2015.05.18.14.57.29
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2015 14:57:29 -0700 (PDT)
Received: by mail-wg0-x232.google.com with SMTP id gq6so29444681wgb.3
        for <rtc-linux@googlegroups.com>; Mon, 18 May 2015 14:57:29 -0700 (PDT)
Message-ID: <555A603F.7000005@gmail.com>
Date: Mon, 18 May 2015 23:57:19 +0200
From: Philippe Reynes <tremyfr@gmail.com>
MIME-Version: 1.0
To: "Enrico Weigelt, metux IT consult" <weigelt@melag.de>
CC: shawn.guo@linaro.org, kernel@pengutronix.de, linux@arm.linux.org.uk,
 a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
 robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
 ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
 rtc-linux@googlegroups.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 fabio.estevam@freescale.com
Subject: [rtc-linux] Re: [PATCH 1/2] rtc: mxc: add a second clock
References: <1431729330-7625-1-git-send-email-tremyfr@gmail.com> <1431729330-7625-2-git-send-email-tremyfr@gmail.com> <5559CC85.5040703@melag.de>
In-Reply-To: <5559CC85.5040703@melag.de>
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

Hi Enrico,

On 18/05/15 13:27, Enrico Weigelt, metux IT consult wrote:
> Am 16.05.2015 um 00:35 schrieb Philippe Reynes:
>> The mxc RTC needs two clocks, one for the input
>> reference, and one for the IP. But this driver
>> was only using one clock (for the reference).
>> This patch add the second clock (for the IP).
>
>
> Does this also apply to MX53, or just MX21 ?

I don't found this rtc on mx53 manual. The mx53 seems to use rtc-imxdi.c.
So, I think it's just for mx21.

Regards,
Philippe
 =20
> greetings,
> --
> Enrico Weigelt, metux IT consult
> +49-151-27565287
> MELAG Medizintechnik oHG Sitz Berlin Registergericht AG Charlottenburg HR=
A 21333 B
>
> Wichtiger Hinweis: Diese Nachricht kann vertrauliche oder nur f=C3=BCr ei=
nen begrenzten Personenkreis bestimmte Informationen enthalten. Sie ist aus=
schlie=C3=9Flich f=C3=BCr denjenigen bestimmt, an den sie gerichtet worden =
ist. Wenn Sie nicht der Adressat dieser E-Mail sind, d=C3=BCrfen Sie diese =
nicht kopieren, weiterleiten, weitergeben oder sie ganz oder teilweise in i=
rgendeiner Weise nutzen. Sollten Sie diese E-Mail irrt=C3=BCmlich erhalten =
haben, so benachrichtigen Sie bitte den Absender, indem Sie auf diese Nachr=
icht antworten. Bitte l=C3=B6schen Sie in diesem Fall diese Nachricht und a=
lle Anh=C3=A4nge, ohne eine Kopie zu behalten.
> Important Notice: This message may contain confidential or privileged inf=
ormation. It is intended only for the person it was addressed to. If you ar=
e not the intended recipient of this email you may not copy, forward, discl=
ose or otherwise use it or any part of it in any form whatsoever. If you re=
ceived this email in error please notify the sender by replying and delete =
this message and any attachments without retaining a copy.

  s

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
