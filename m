Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41947EB64D9
	for <linux-rtc@archiver.kernel.org>; Wed, 14 Jun 2023 12:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243946AbjFNMQe (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Wed, 14 Jun 2023 08:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243985AbjFNMQc (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Wed, 14 Jun 2023 08:16:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637101FC7;
        Wed, 14 Jun 2023 05:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686744986; x=1718280986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lXIww3R8oE2mnyCB8FLd9dnkhHpRmtz39UaDyJ0b2qg=;
  b=TQprOryB+Pv0WoXnwGcCEl2qeATqJjB8R19g54lS540APOs3qMOraWxP
   p8hqMPKPxBKbfo+pM/pDfGxCqncCwproO2WMrS/VLVOl0R5Q3Rvj84cqi
   6aejFxtKT07pX6yeQrCIXizdMiJS0dnYsPWVt5b0OYdDREAdYTavLCPf0
   JMU8AOQKrB8d4nV8XaDnWm6vysEujJ5v+YgLygg/RK0sc3sQ+BBRhK/W4
   inBYYKqd9Au0wAz0IZ/Tpn6cDqz8JfJF8leXfUem5EHrwN9Ww6A8kTe9V
   NVqHVeKjvC+AGfKZJzfioUnIczcAx6HphmEwox99lQ1D1VEMwCLv8Jtpf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="348256688"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="348256688"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 05:16:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="715176844"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="715176844"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP; 14 Jun 2023 05:16:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q9PQ6-003hE7-0y;
        Wed, 14 Jun 2023 15:16:14 +0300
Date:   Wed, 14 Jun 2023 15:16:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alessandro Zummo <a.zummo@towertech.it>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/8] rtc: isl12022: implement RTC_VL_READ ioctl
Message-ID: <ZImvjj34YILrNJU5@smile.fi.intel.com>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-6-linux@rasmusvillemoes.dk>
 <ZIiJWKBFojAcNCkA@smile.fi.intel.com>
 <20230613212651c8770218@mail.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230613212651c8770218@mail.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Tue, Jun 13, 2023 at 11:26:51PM +0200, Alexandre Belloni wrote:
> On 13/06/2023 18:20:56+0300, Andy Shevchenko wrote:
> > On Tue, Jun 13, 2023 at 03:00:07PM +0200, Rasmus Villemoes wrote:

...

> > > +		ret = regmap_read(regmap, ISL12022_REG_SR, &val);
> > > +		if (ret < 0)
> > 
> > I always feel uneasy with ' < 0' — Does positive error makes sense?
> > Is it even possible? OTOH if the entire driver uses this idiom...
> > oh well, let's make it consistent.
> 
> /**
>  * regmap_read() - Read a value from a single register
>  *
>  * @map: Register map to read from
>  * @reg: Register to be read from
>  * @val: Pointer to store read value
>  *
>  * A value of zero will be returned on success, a negative errno will
>  * be returned in error cases.
>  */

I'm not sure what you meant by this. Yes, I know that there is no
possibility that regmap API returns positive value. Do you mean that
regmap API documentation is unclear?

> > > +			return ret;

-- 
With Best Regards,
Andy Shevchenko


