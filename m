Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5399BC83F3E
	for <linux-rtc@archiver.kernel.org>; Tue,  5 Sep 2023 22:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbjIEWGg (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 5 Sep 2023 18:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjIEWGg (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 5 Sep 2023 18:06:36 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16611E6;
        Tue,  5 Sep 2023 15:06:30 -0700 (PDT)
Received: from mail.denx.de (unknown [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id C5BAF86543;
        Wed,  6 Sep 2023 00:06:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693951582;
        bh=KSYPX9ZZMGT/6uNJc7MPL0OTCQ8OVTEsL/MtqUU+ueE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SkGobUQLI3BwUXa+Lohf3G2t+B6wxrK6EXu1ddszxnlceON5RPStjLOkhzx2Rz3GC
         YmT0BLn3doHu+CV6aDNgYemJxyOm4W4tWdWNc6v2OqD5U6HO9bYiogOkPGKDj7kWWz
         XYcXXsW9axUrlxtocFKKsERiHsWcRjNl6ttRK2U+bCCthLa7AKS2CvCxkQ/A5cLL+m
         RxAk4KOWjWFeqTB8hqOkDxKLJuVR49cr6bIdUbqey5EpK0mG0ppMr/7qM6tDIlDXrZ
         jKeFLaExjjMZ3djPgaP6w6SshR+KxXlQDcbk2UxMTBdeCAUFxwZ76bDeI8mRnXwgyK
         KfQP75/j1ASCg==
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 Sep 2023 19:06:22 -0300
From:   Fabio Estevam <festevam@denx.de>
To:     Javier Carrasco <javier.carrasco@wolfvision.net>
Cc:     Fabio Estevam <festevam@gmail.com>, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, sam@ravnborg.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: rtc: pcf8523: Convert to YAML
In-Reply-To: <08130247-1ccb-1233-3feb-a60e6c0b3610@wolfvision.net>
References: <20230905202827.67212-1-festevam@gmail.com>
 <08130247-1ccb-1233-3feb-a60e6c0b3610@wolfvision.net>
Message-ID: <d699c0d642008bfdd97cee467182560d@denx.de>
X-Sender: festevam@denx.de
User-Agent: Roundcube Webmail/1.3.6
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Hi Javier,

On 05/09/2023 19:03, Javier Carrasco wrote:

> isn't the default value 12500 anymore? it used to be and the driver
> still uses 12500fF as the default value.

You are right.

I will fix it in v3.

Thanks,

Fabio Estevam
