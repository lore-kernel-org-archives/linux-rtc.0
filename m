Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B246EC0015E
	for <linux-rtc@archiver.kernel.org>; Thu, 27 Jul 2023 21:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjG0VNt (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Thu, 27 Jul 2023 17:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjG0VNs (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Thu, 27 Jul 2023 17:13:48 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB68D30E3;
        Thu, 27 Jul 2023 14:13:46 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D74C61BF209;
        Thu, 27 Jul 2023 21:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690492425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ICP7QruovvJZMT9MsB6asg3zuA+Hv+TdzoNUmf2wZsg=;
        b=eZif2qUy/f1CP77FP0RTtPDZyfjoH0dj1+FcrJ54ZJ2MPulbzN6nLXBCAgxhzJzpEwOe7o
        IxIrdMUfBwXWodUagm+/8eE7O11v3fgCzrRNQOWFVKcGphzU2kcPmPtM1+JmvQ4xG8fpp2
        4o28xO0h2nCkzKiUGUDf8exAWGNtaf8ztybdbWwA8O4WXXu06axwJ/c31c9x+3ZMK+SvT5
        ygSsG0qYQaYE0DVa5D8DyyQuepwtA5FHRceHsCc0TrG44lb51c/uDzYvLTL/SieCXf9UGe
        F3O360Og7WZ8zMgDuM3HuJwCQZbvyLTW0IsQUjhxVIVRIgRFhNSnTJYlLAc7Tg==
Date:   Thu, 27 Jul 2023 23:13:44 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     a.zummo@towertech.it, Andrej Picej <andrej.picej@norik.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        upstream@phytec.de
Subject: Re: [PATCH v3] rtc: rv3028: Add support for "aux-voltage-chargeable"
 property
Message-ID: <169049240059.468125.18081485399820108743.b4-ty@bootlin.com>
References: <20230623081533.76334-1-andrej.picej@norik.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623081533.76334-1-andrej.picej@norik.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org


On Fri, 23 Jun 2023 10:15:33 +0200, Andrej Picej wrote:
> Property "trickle-resistor-ohms" allows us to set trickle charger
> resistor. However there is no possibility to disable it afterwards.
> 
> Add support for "aux-voltage-chargeable" property which can be used to
> enable/disable the trickle charger circuit explicitly. The default
> behavior of the code is kept as it is!
> 
> [...]

Applied, thanks!

[1/1] rtc: rv3028: Add support for "aux-voltage-chargeable" property
      commit: 3c87b351809f220294aec3c0df7b078ff5c5b15b

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
