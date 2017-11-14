Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-ot0-f179.google.com ([74.125.82.179]:54528 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754879AbdKNKdL (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 14 Nov 2017 05:33:11 -0500
Received: by mail-ot0-f179.google.com with SMTP id w8so16196191otw.11
        for <linux-rtc@vger.kernel.org>; Tue, 14 Nov 2017 02:33:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171114102614.g2bxstg5qacvmtk6@piout.net>
References: <D24E577EA1E37B4788A3BFBC418F14A70760C04A@wetsrvex01.loepfe.com>
 <3BB206AB2B1BD448954845CE6FF69A8E01B8E754AA@NT-Mail07.beckhoff.com>
 <20171109030327.anzo47xayxckn47r@piout.net> <3BB206AB2B1BD448954845CE6FF69A8E01CB52290E@NT-Mail07.beckhoff.com>
 <20171113161522.2kq7un7gl5vg4qlq@piout.net> <CAOMZO5Bi5PcuGiVRZykw9Zp-ysHmHzThhwNai-cqy3HRTUKQAg@mail.gmail.com>
 <CAOMZO5AOAo8OU86CrneFeWuu2ti1sea9843UQ16=7AyU5-B11Q@mail.gmail.com>
 <3BB206AB2B1BD448954845CE6FF69A8E01CB52F4BE@NT-Mail07.beckhoff.com>
 <CAOMZO5B_RcXb6X7gUVSJbDpKSHj9eqtDqcYHjEN1n6zhkyCAjQ@mail.gmail.com> <20171114102614.g2bxstg5qacvmtk6@piout.net>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 14 Nov 2017 08:33:09 -0200
Message-ID: <CAOMZO5CdGAqBkBQ5DdphzNr-tB5r7Sj9jBAhFTFPNezTEjJOMg@mail.gmail.com>
Subject: Re: DryIce , RTC not working on imx53.
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: =?UTF-8?Q?Patrick_Br=C3=BCnn?= <P.Bruenn@beckhoff.com>,
        Juergen Borleis <jbe@pengutronix.de>,
        "Vellemans, Noel" <Noel.Vellemans@visionbms.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Tue, Nov 14, 2017 at 8:26 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:

>> I have the impression that the dryice driver has never worked in
>> mainlune for mx53.
>>
>
> I doubt that because it seems to have been used by Pengutronix.

Juergen can confirm, but it seems the dryice driver was only used on
mx25 in mainline.
