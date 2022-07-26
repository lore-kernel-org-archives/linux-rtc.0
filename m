Return-Path: <linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475CEC04A68
	for <linux-rtc@archiver.kernel.org>; Tue, 26 Jul 2022 15:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239201AbiGZPIJ (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 26 Jul 2022 11:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239319AbiGZPIG (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 26 Jul 2022 11:08:06 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B872ED5D;
        Tue, 26 Jul 2022 08:08:04 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 376044000A;
        Tue, 26 Jul 2022 15:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1658848083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8NTWt49n7i7rtCFJqnmX9cU+SAQ2/o+Kao1bPB1QoXg=;
        b=G+XIJeXSRqvzKNIKIuAkT8MRlP34AW91vnLLARpAupH/85k3q+dk6z0XsUIIgjucs/RPU6
        keGsMb/D4sXEl3k2biUg04A3cVFzYtsEsBfEtBnOOClctUV3SzkD3sJqGXLBcL8q4d+Ykd
        qBNf8zinyLzyGU2oUKP9Yt2Ucfu8th5/acqerILoRO//IahQJT+CTvIkgBVA5mg7eiZ6f+
        ILdsCox1U/BAhxVfxQfR5LhCsKoIJFXk0kQRIz/jPUUJzcg6eyLvZjeUQ1vuQ4QSXrxAEm
        OR24Pa99GRcjf5ahg0SCZchfIn3ephhQ7/ZYFLngMUb8LBly8vrCUDDiWU16fw==
Date:   Tue, 26 Jul 2022 17:07:54 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     KWLIU@nuvoton.com, tali.perry1@gmail.com, avifishman70@gmail.com,
        medadyoung@gmail.com, mimi05633@gmail.com, ctcchien@nuvoton.com,
        benjaminfair@google.com, JJLIU0@nuvoton.com,
        krzysztof.kozlowski+dt@linaro.org, yuenn@google.com,
        KFTING@nuvoton.com, YSCHU@nuvoton.com, venture@google.com,
        mylin1@nuvoton.com, robh+dt@kernel.org, tmaimon77@gmail.com,
        a.zummo@towertech.it
Cc:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: (subset) [PATCH v6 0/3] RTC: nuvoton: Add nuvoton real time
 clock driver
Message-ID: <165884805334.3164065.49376707444358080.b4-ty@bootlin.com>
References: <20220713090647.8028-1-mimi05633@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713090647.8028-1-mimi05633@gmail.com>
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Wed, 13 Jul 2022 17:06:44 +0800, Mia Lin wrote:
> Support Nuvoton NCT3018Y real time clock.
> 
> Changes since version 6:
>  - Add review tag.
>  - Add blank line in dts.
> 
> Changes since version 5:
>  - Add battery voltage level check by NCT3018Y_REG_ST.
>  - Remove disable clock output.
>  - Fix errors in rtc-nct3018y.c.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: rtc: nuvoton: add NCT3018Y Real Time Clock
      commit: 8b30b09317ec6fda5f36a428e9e331253b5c4739
[3/3] RTC: nuvoton: Add NCT3018Y real time clock driver
      commit: 5adbaed16cc63542057627642d2414f603f2db69

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
