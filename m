Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9394EB64DD
	for <linux-rtc@archiver.kernel.org>; Thu, 27 Jul 2023 21:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjG0Vcm (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 27 Jul 2023 17:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbjG0Vcm (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 27 Jul 2023 17:32:42 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0954D9
        for <linux-rtc@vger.kernel.org>; Thu, 27 Jul 2023 14:32:39 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A95511BF203;
        Thu, 27 Jul 2023 21:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690493558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sJ4FSyaHK/hqkZlHiSNTXevbleO08mIiPpWuf0D4SKE=;
        b=okyO25kMNo4pPxny2VnAiBzcMuQNhASct93xQ/9mA3ETavA0XHu7+ZrPfHRhaCTOapAuzD
        qOMkzIr55wd2KjBu+zXMonOoEvGbIYe+tMzv0cl4P5H2lIThoQiaYLYZt7W1HH+4NFFL3Z
        dTrb6r+PylfRUeaSSCWW4/yop/goD2qNCL9j8SPqWeKsrujxi6imCYp1DUPqYZk8ZPC4V4
        pH3VvoCeYUKYXlRL+xM2yJhtiUxxmk+3QzUlJnzHqbijXcSMp8VjEoSvEVSY9D5fom2/EN
        EfXcOK6oXAx1TcM1mvl8CbFXgtsrZD+HKwnM+a4derIRvj3y7iIJbHt/seKP3Q==
Date:   Thu, 27 Jul 2023 23:32:36 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-rtc@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] rtc: isl12026: Drop "_new" from probe callback name
Message-ID: <169049354229.642210.15451606982761104806.b4-ty@bootlin.com>
References: <20230725070429.383070-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230725070429.383070-1-u.kleine-koenig@pengutronix.de>
X-GND-Sasl: alexandre.belloni@bootlin.com
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org


On Tue, 25 Jul 2023 09:04:29 +0200, Uwe Kleine-König wrote:
> The driver was introduced when .probe_new was the right probe callback
> to use for i2c drivers. Today .probe is the right one (again) and the
> driver was already switched in commit 31b0cecb4042 ("rtc: Switch i2c
> drivers back to use .probe()") but the name continued to include "_new"
> in its name.
> 
> To prevent code readers wondering about what might be new here, drop
> that irritating part of the name.
> 
> [...]

Applied, thanks!

[1/1] rtc: isl12026: Drop "_new" from probe callback name
      commit: 58f3e83260a78cfd5648efa5448b237b9c230fc0

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
