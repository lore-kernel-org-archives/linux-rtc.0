Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:46746 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754165AbdKNKNP (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 14 Nov 2017 05:13:15 -0500
Received: by mail-oi0-f47.google.com with SMTP id n16so4233463oig.3
        for <linux-rtc@vger.kernel.org>; Tue, 14 Nov 2017 02:13:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <D24E577EA1E37B4788A3BFBC418F14A707646377@wetsrvex01.loepfe.com>
References: <D24E577EA1E37B4788A3BFBC418F14A70760C04A@wetsrvex01.loepfe.com>
 <3BB206AB2B1BD448954845CE6FF69A8E01B8E754AA@NT-Mail07.beckhoff.com>
 <20171109030327.anzo47xayxckn47r@piout.net> <3BB206AB2B1BD448954845CE6FF69A8E01CB52290E@NT-Mail07.beckhoff.com>
 <20171113161522.2kq7un7gl5vg4qlq@piout.net> <CAOMZO5Bi5PcuGiVRZykw9Zp-ysHmHzThhwNai-cqy3HRTUKQAg@mail.gmail.com>
 <CAOMZO5AOAo8OU86CrneFeWuu2ti1sea9843UQ16=7AyU5-B11Q@mail.gmail.com>
 <3BB206AB2B1BD448954845CE6FF69A8E01CB52F4BE@NT-Mail07.beckhoff.com> <D24E577EA1E37B4788A3BFBC418F14A707646377@wetsrvex01.loepfe.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 14 Nov 2017 08:13:14 -0200
Message-ID: <CAOMZO5BqhhFMRByY+cHXcqmUiLVVngYHvjmTcNJP8M08ew8xnw@mail.gmail.com>
Subject: Re: DryIce , RTC not working on imx53.
To: "Vellemans, Noel" <Noel.Vellemans@visionbms.com>
Cc: =?UTF-8?Q?Patrick_Br=C3=BCnn?= <P.Bruenn@beckhoff.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Noel,

On Tue, Nov 14, 2017 at 4:40 AM, Vellemans, Noel
<Noel.Vellemans@visionbms.com> wrote:
> HI all,
>
> I've been digging a while in the DryIce code (some time ago, it was in a hurry because I needed to release).
>
> I finally ended up by NOT using the DryIce code , for the IMX53 ( internal RTC)
>
> If I recall correctly , this is not the correct driver for the Internal IMX53 RTC, ( for example the register BASE-Addresses / offsets are not correct..)
> resulting in all kind of strange behavior, depending on your situational use-cases:-(

Could you clarify about this? Which base address or offsets are not correct?
