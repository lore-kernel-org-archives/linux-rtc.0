Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368B1ECAAD3
	for <linux-rtc@archiver.kernel.org>; Wed, 14 Sep 2022 15:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiINPRS (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 14 Sep 2022 11:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiINPRH (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 14 Sep 2022 11:17:07 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E346D80B77;
        Wed, 14 Sep 2022 08:16:59 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 46383100006;
        Wed, 14 Sep 2022 15:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663168615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M5IGgcU2WIxFb3FzPqZ14HIF1sUe8Tr38VMHu2F1u/0=;
        b=HuIYUNpe73gEMmWVDFN5DGe0Eyb3dJJ/h8+zBulz6r9LPxvJ6tWZBUbY75vrLFaCixpAX9
        1kOP4VEgiYVXVB63fvBuYWfhJtzeRmVj1f906hEbavEUAR/voeefpOPaGm5KvhF9+EXngj
        8tk3l/KE36LayXgS9t2pqWOwHxOZxcqFrKQkMtSlxjbX1g7OlixolTkPqbR6dLZH0Wyrfj
        gfd87NxBUfChXhtMi0DNZQQi2CdB61mrHijoBY5BpTZ2uoQUMykGWDAOVxQiWfpNmKCTHF
        GGy0PCMaF+vmdgTFu9L8/0Bg08VhwKdAZ3/SB7lbelcNGIvby1KqIewulHXe/Q==
Date:   Wed, 14 Sep 2022 17:16:53 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 0/6] rtc: isl12022: cleanups and hwmon support
Message-ID: <YyHwZbAiycgnQQFO@mail.local>
References: <20220830100152.698506-1-linux@rasmusvillemoes.dk>
 <174dd607-25b6-26c0-e6e7-1634c5b01dbc@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174dd607-25b6-26c0-e6e7-1634c5b01dbc@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On 09/09/2022 10:15:22+0200, Rasmus Villemoes wrote:
> On 30/08/2022 12.01, Rasmus Villemoes wrote:
> > This series does a few cleanups of the isl12022 driver,
> > 
> > - removes use of deprecated function
> > - removes some  redundant code
> > - switches to regmap API instead of private helpers
> > 
> > and finally hooks up the temperatur sensor to hwmon.
> 
> ping. Any comments before I respin 6/6 to address Guenter's request?
> 

This series is missing one patch setting the datetime range supported by
the RTC which I guess is 2000 to 2099.

> Rasmus

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
