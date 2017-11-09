Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from netsrv01.beckhoff.com ([62.159.14.10]:61899 "EHLO
        Netsrv01.beckhoff.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751190AbdKIJ7Z (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 9 Nov 2017 04:59:25 -0500
From: =?iso-8859-1?Q?Patrick_Br=FCnn?= <P.Bruenn@beckhoff.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: "Vellemans, Noel" <Noel.Vellemans@visionBMS.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
Subject: RE: DryIce , RTC not working on imx53.
Date: Thu, 9 Nov 2017 09:59:02 +0000
Message-ID: <3BB206AB2B1BD448954845CE6FF69A8E01CB52290E@NT-Mail07.beckhoff.com>
References: <D24E577EA1E37B4788A3BFBC418F14A70760C04A@wetsrvex01.loepfe.com>
 <3BB206AB2B1BD448954845CE6FF69A8E01B8E754AA@NT-Mail07.beckhoff.com>
 <20171109030327.anzo47xayxckn47r@piout.net>
In-Reply-To: <20171109030327.anzo47xayxckn47r@piout.net>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>


>From: Alexandre Belloni [mailto:alexandre.belloni@free-electrons.com]
>Sent: Donnerstag, 9. November 2017 04:03
>
>hwclock times out because the alarm is not working properly. Can you
>check whether rtctest is working?
>
You mean "tools/testing/selftests/timers/rtctest", right?

I just run it and it's stuck at "Counting 5 update (1/sec) interrupts from reading /dev/rtc0:"

Kernel log shows a new message for each try I restart rtctest.
[ 1032.349562] imxdi_rtc 53fa4000.srtc: Write-wait timeout val = 0x5a042418 reg = 0x00000008"


Regards, Patrick

Beckhoff Automation GmbH & Co. KG | Managing Director: Dipl. Phys. Hans Beckhoff
Registered office: Verl, Germany | Register court: Guetersloh HRA 7075
