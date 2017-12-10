Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-ot0-f171.google.com ([74.125.82.171]:34188 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751991AbdLJTDU (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Sun, 10 Dec 2017 14:03:20 -0500
MIME-Version: 1.0
In-Reply-To: <3BB206AB2B1BD448954845CE6FF69A8E01CB531C1F@NT-Mail07.beckhoff.com>
References: <20171205140646.30367-1-linux-kernel-dev@beckhoff.com>
 <20171205140646.30367-3-linux-kernel-dev@beckhoff.com> <CAOMZO5DiRa1aLFHiFv_-_3J9LLuq-J06FHLQ4o7=r8hrftEpqQ@mail.gmail.com>
 <3BB206AB2B1BD448954845CE6FF69A8E01CB531C1F@NT-Mail07.beckhoff.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 10 Dec 2017 17:03:19 -0200
Message-ID: <CAOMZO5Bo2PkjjM+Z8Ee6v3Doj0Mq6R_df_5Wry8NqhKj7aMiHA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] ARM: dts: imx53: add srtc node
To: =?UTF-8?Q?Patrick_Br=C3=BCnn?= <P.Bruenn@beckhoff.com>
Cc: linux-kernel-dev <linux-kernel-dev@beckhoff.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM"
        <linux-rtc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Noel Vellemans <Noel.Vellemans@visionbms.com>,
        Rob Herring <robh+dt@kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?Q?Lothar_Wa=C3=9Fmann?= <LW@karo-electronics.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Tue, Dec 5, 2017 at 12:20 PM, Patrick Br=C3=BCnn <P.Bruenn@beckhoff.com>=
 wrote:

> I will wait a few days for more reviewers and then integrate your comment=
s in a v3. If nothing major show up I will wait until the imx53.dtsi revert=
 landed in Linus tree.

It is in Linus' tree now as commit e501506d3ea0 ("Revert "ARM: dts:
imx53: add srtc node"").
