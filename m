Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mxord1.mothictech.com ([99.198.117.115]:39468 "EHLO
        mxord1.mothictech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751835AbeBFBSl (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Mon, 5 Feb 2018 20:18:41 -0500
Subject: Re: [PATCH] rtc: remove rtc-at32ap700x
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>, a.zummo@towertech.it,
        linux-rtc@vger.kernel.org
References: <20180118200846.14368-1-clabbe.montjoie@gmail.com>
 <20180119072733.dkswccdbnisbmqi6@samfundet.no>
 <20180119085835.GW2678@piout.net>
From: Brandon Martin <martinbv@mothictech.com>
Message-ID: <b1ad9b75-5a1f-f84c-da49-917f491325d5@mothictech.com>
Date: Mon, 5 Feb 2018 20:09:32 -0500
MIME-Version: 1.0
In-Reply-To: <20180119085835.GW2678@piout.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

On 01/19/2018 03:58 AM, Alexandre Belloni wrote:
> Well, my plan was to keep it for a little while, but whatever :)

As far as I know, the AVR32 AP7x architecture has been commercially dead for far longer than it was ever active.  I'd agree - axe it if support for the overall architecture is on its way out, too.
-- 
Brandon Martin
Mothic Technologies
317-565-1357 x7000
