Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:37960 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752628AbdHWA3N (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 22 Aug 2017 20:29:13 -0400
Date: Tue, 22 Aug 2017 19:29:11 -0500
From: Rob Herring <robh@kernel.org>
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Roc He <hepeng@zidoo.tv>,
        =?utf-8?B?6JKL5Li955C0?= <jiang.liqin@geniatech.com>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [RFC 1/3] dt-bindings: rtc: Add Realtek RTD1295
Message-ID: <20170823002911.y35nn7jkt34dvjbc@rob-hp-laptop>
References: <20170820013632.18375-1-afaerber@suse.de>
 <20170820013632.18375-2-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170820013632.18375-2-afaerber@suse.de>
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On Sun, Aug 20, 2017 at 03:36:29AM +0200, Andreas Färber wrote:
> Add a binding for the RTC on the Realtek RTD119x/RTD129x SoC families.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  .../devicetree/bindings/rtc/realtek,rtd119x.txt          | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rtc/realtek,rtd119x.txt

Acked-by: Rob Herring <robh@kernel.org>
