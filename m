Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:55719 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030329AbdIZNlE (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 26 Sep 2017 09:41:04 -0400
Date: Tue, 26 Sep 2017 15:40:52 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] powerpc/5200: dts: digsy_mtc.dts: fix rv3029
 compatible
Message-ID: <20170926134052.pjntycy5tbxggmvl@piout.net>
References: <20170915020004.24272-1-alexandre.belloni@free-electrons.com>
 <20170915020004.24272-3-alexandre.belloni@free-electrons.com>
 <20170915091326.4b93bde1@crub>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170915091326.4b93bde1@crub>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi,

On 15/09/2017 at 09:13:26 +0200, Anatolij Gustschin wrote:
> On Fri, 15 Sep 2017 04:00:04 +0200
> Alexandre Belloni alexandre.belloni@free-electrons.com wrote:
> 
> >The proper compatible for rv3029 is microcrystal,rv3029.
> >
> >Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> 
> Acked-by: Anatolij Gustschin <agust@denx.de>

If that is fine for you, I would prefer that goes through your tree as
I'm not usually taking DT patches through the RTC tree. there is no
dependency as the i2c subsystem will already match the new compatible
with the i2c device_id.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
