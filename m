Return-Path: <rtc-linux+bncBDA7X7F2WUEBBQPAZW2AKGQEY3R42SI@googlegroups.com>
Received: from mail-wm0-x22a.google.com (mail-wm0-x22a.google.com. [2a00:1450:400c:c09::22a])
        by gmr-mx.google.com with ESMTPS id w129si408081wme.1.2016.01.11.01.05.05
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2016 01:05:05 -0800 (PST)
Received: by mail-wm0-x22a.google.com with SMTP id l65so201787895wmf.1
        for <rtc-linux@googlegroups.com>; Mon, 11 Jan 2016 01:05:05 -0800 (PST)
Date: Mon, 11 Jan 2016 09:05:01 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: rtc-linux@googlegroups.com, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, linus.walleij@linaro.org, gnurou@gmail.com,
	broonie@kernel.org, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, lgirdwood@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, swarren@nvidia.com, treding@nvidia.com,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Chaitanya Bandi <bandik@nvidia.com>,
	Mallikarjun Kasoju <mkasoju@nvidia.com>
Subject: Re: [rtc-linux] [PATCH 2/6] mfd: max77620: add core driver for MAX77620/MAX20024
Message-ID: <20160111090501.GG14104@x1>
References: <1452177524-23192-1-git-send-email-ldewangan@nvidia.com>
 <1452177524-23192-3-git-send-email-ldewangan@nvidia.com>
 <CAJKOXPfa0jjRWE6LKvNmwCRcG9Es7=36_03kTqCx-aB1wENx0g@mail.gmail.com>
 <20160111054627.GB3331@x1>
 <56934AFD.5060008@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <56934AFD.5060008@samsung.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Mon, 11 Jan 2016, Krzysztof Kozlowski wrote:

> On 11.01.2016 14:46, Lee Jones wrote:
> > On Fri, 08 Jan 2016, Krzysztof Kozlowski wrote:
> >=20
> > Thanks for taking the time to review.
> >=20
> >> ()2016-01-07 23:38 GMT+09:00 Laxman Dewangan <ldewangan@nvidia.com>:
> >>> MAX77620/MAX20024 are Power Management IC from the MAXIM.
> >>> It supports RTC, multiple GPIOs, multiple DCDC and LDOs,
> >>> watchdog, clock etc.
> >>>
> >>> Add MFD drier to provides common support for accessing the
> >>> device; additional drivers is developed on respected subsystem
> >>> in order to use the functionality of the device.
> >>>
> >>> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> >>> Signed-off-by: Chaitanya Bandi <bandik@nvidia.com>
> >>> Signed-off-by: Mallikarjun Kasoju <mkasoju@nvidia.com>
> >>> Tested-by: Venkat Reddy Talla <vreddytalla@nvidia.com>
> >>
> >> The Testing and Reviewed are statements (see SubmittingPatches) so
> >> they should be made explicitly by people. As this is v1 how they could
> >> make a public statement so far?
> >=20
> > SubmittingPatches bears no mention that Reviewed-by/Tested-by
> > statements have to be provided on one of the public mailing lists.
> > These can be provided privately prior to upstream submission v1.
>=20
> Indeed the document does not mention that they have to be provided by
> public.
>=20
> In the same time these are statements given by a reviewer ("By offering
> my Reviewed-by: tag, I state that:")... and how can you validate a
> statement given through a private channel? Is it true? Is it a thorough
> testing or just copy-paste from Gerrit (or other automated system)?

That is for the submitter's conscience to decide.  If the statements
are supplied, we must assume they were provided in good faith and in
accordance with the rules set out by the Linux Kernel.  We can not ask
for every Tested-by/Acked-by/Reviewed-by/etc provider to verify on
each upstream submission.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

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
