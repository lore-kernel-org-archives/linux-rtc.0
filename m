Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36426 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751189AbdH0Klt (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sun, 27 Aug 2017 06:41:49 -0400
Subject: Re: [RFC 1/3] dt-bindings: rtc: Add Realtek RTD1295
To: Rob Herring <robh@kernel.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Roc He <hepeng@zidoo.tv>,
        =?UTF-8?B?6JKL5Li955C0?= <jiang.liqin@geniatech.com>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
References: <20170820013632.18375-1-afaerber@suse.de>
 <20170820013632.18375-2-afaerber@suse.de>
 <20170823002911.y35nn7jkt34dvjbc@rob-hp-laptop>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <629b9ed0-7b2d-7c5c-20b8-17289a76f097@suse.de>
Date: Sun, 27 Aug 2017 12:41:46 +0200
MIME-Version: 1.0
In-Reply-To: <20170823002911.y35nn7jkt34dvjbc@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Hi Rob,

Am 23.08.2017 um 02:29 schrieb Rob Herring:
> On Sun, Aug 20, 2017 at 03:36:29AM +0200, Andreas Färber wrote:
>> Add a binding for the RTC on the Realtek RTD119x/RTD129x SoC families.
>>
>> Signed-off-by: Andreas Färber <afaerber@suse.de>
>> ---
>>  .../devicetree/bindings/rtc/realtek,rtd119x.txt          | 16 ++++++++++++++++
>>  1 file changed, 16 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/rtc/realtek,rtd119x.txt
> 
> Acked-by: Rob Herring <robh@kernel.org>

Thanks. Did you read the RFC question in the cover letter as well and
have any comments? Downstream has an rtc-base-year = <2014>; property
that I had left out in this RFC and due to your ack not included in v2.

Should we default to 2014 in the driver and add an optional base-year
property once we encounter a diverging device, or should we make it
required from the beginning? I did not spot any other rtc binding with
such a property and would appreciate a clarification.

Thanks in advance,

Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
