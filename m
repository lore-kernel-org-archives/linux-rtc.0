Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35892 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751181AbdH0K2k (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Sun, 27 Aug 2017 06:28:40 -0400
Subject: Re: [PATCH v2 2/3] rtc: Add Realtek RTD1295
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ????????? <jiang.liqin@geniatech.com>,
        linux-kernel@vger.kernel.org, Roc He <hepeng@zidoo.tv>
References: <20170827003328.28370-1-afaerber@suse.de>
 <20170827003328.28370-3-afaerber@suse.de> <20170827020501.GB13622@lunn.ch>
 <a2a21bc4-b7a9-cadf-920c-f078c673dbb9@suse.de>
 <20170827082714.nya7m3movufujtjk@piout.net>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <1e054135-b825-5d3e-e508-201589b0c451@suse.de>
Date: Sun, 27 Aug 2017 12:28:38 +0200
MIME-Version: 1.0
In-Reply-To: <20170827082714.nya7m3movufujtjk@piout.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

Am 27.08.2017 um 10:27 schrieb Alexandre Belloni:
> On 27/08/2017 at 04:30:08 +0200, Andreas Färber wrote:
>> Am 27.08.2017 um 04:05 schrieb Andrew Lunn:
>> By that same argument we could ask why so many drivers (and mine, too)
>> are calling rtc_valid_tm() when __rtc_read_time() calls it again...
> 
> Most of them probably predates the introduction of the check in
> __rtc_read_time().

Replacing with 0 here then.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
