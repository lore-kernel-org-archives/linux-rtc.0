Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2C1C27C6E
	for <linux-rtc@archiver.kernel.org>; Wed, 16 Aug 2023 22:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbjHPW5e (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 16 Aug 2023 18:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347013AbjHPW5O (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 16 Aug 2023 18:57:14 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C102698;
        Wed, 16 Aug 2023 15:57:09 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 95D0B240003;
        Wed, 16 Aug 2023 22:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692226628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pFOA/J/kGOq5kjmjh+ySEHDrfyJ+jQg9HCMLA+yWcNw=;
        b=CCrYCVlmwGGBOj7z/zkaC+bRe/+z5PM4RIPjSD0aMuBMa9GrsDNKh7jL/wahiBuqxpRIAg
        HrV0excNGzp6+2E5BNRSCgq5zYzRD4m8vDbyCi/MIgmE9b23PdSbU1h0hNVpq9v/eIqOAM
        I3U3YfIq+9MxS9VLusIvCpycjBi2Pw8yBeIWetkQ8n42AZCPUnHsJ9YUWmQlHsXrqLfbo9
        saDvHCWqMAICLnBJ3nHHOjf7mUeX/jMxjMfvHz/KX07z8bxYxmD0vKRQBQ0OAEP7HUmH1x
        Ua4S+/0+xc/s6Ljo8vxfV4Yr/MblUGyaxLVx6YEUllVPTYNf7zWu52G7t/RO+A==
Date:   Thu, 17 Aug 2023 00:57:05 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Sven Schnelle <svens@stackframe.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: ds2404: Convert to GPIO descriptors
Message-ID: <169222659255.112288.18244763922545129118.b4-ty@bootlin.com>
References: <20230807-descriptors-rtc-v1-1-ce0f9187576e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807-descriptors-rtc-v1-1-ce0f9187576e@linaro.org>
X-GND-Sasl: alexandre.belloni@bootlin.com
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org


On Mon, 07 Aug 2023 09:31:06 +0200, Linus Walleij wrote:
> This converts the DS2404 to use GPIO descriptors instead of
> hard-coded global GPIO numbers.
> 
> The platform data can be deleted because there are no in-tree
> users and it only contained GPIO numbers which are now
> passed using descriptor tables (or device tree or ACPI).
> 
> [...]

Applied, thanks!

[1/1] rtc: ds2404: Convert to GPIO descriptors
      commit: d890cfc25fe9421ffdff3a9ea678172addb36762

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
