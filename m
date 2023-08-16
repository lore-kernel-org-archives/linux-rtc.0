Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B165C27C53
	for <linux-rtc@archiver.kernel.org>; Wed, 16 Aug 2023 23:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244171AbjHPXEC (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 16 Aug 2023 19:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347134AbjHPXDo (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 16 Aug 2023 19:03:44 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A6C2705;
        Wed, 16 Aug 2023 16:03:29 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id F3077C0002;
        Wed, 16 Aug 2023 23:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692227008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wdw4rxYQOSoWap4Dy/YjhgEEkk3/DkKeHRVnfH7gppk=;
        b=EDrGyXX68UQeJXymOb5/35ck+eLxKEiD2I/kqiiwmPo9E4atpO6ksjZqMYmqo8CJYKxmCI
        inpcVjYvBrZmfVYWh7YMMkLz3PMB1GFfhSxAbL3zi8IxuKS/OkGWkd3/dQmb1hYZ+HBkVL
        7568hdUkTidfJSrUP/uYXrjJZnhWrttDsuYUnwJlbBISNFxMlLN9uO98Zo8MhvfzwFNvXO
        f974ZKe7Z5hegeiUG7aOundzor5PQzJMzJabL6wUmpamOJX51iGz+37ZfGM6ABxmSnDrDV
        bVANs+LvZGRejjuIUikolON7k2gcs77aqlDHVVFO38jJBiEASpXILKgwJoVgNw==
Date:   Thu, 17 Aug 2023 01:03:24 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Hugo Villeneuve <hugo@hugovil.com>
Cc:     Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] rtc: pcf2127: add error checking when
 disabling POR0
Message-ID: <169222693690.116276.11657105955678173166.b4-ty@bootlin.com>
References: <20230728171211.3016019-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728171211.3016019-1-hugo@hugovil.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org


On Fri, 28 Jul 2023 13:12:12 -0400, Hugo Villeneuve wrote:
> If PCF2127 device is absent from the I2C bus, or if there is a
> communication problem, disabling POR0 may fail silently and we
> still continue with probing the device. In that case, abort probe
> operation.
> 
> 

Applied, thanks!

[1/1] rtc: pcf2127: add error checking when disabling POR0
      commit: e4163fc59d088caf3250cc9c9862239a954d85b5

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
