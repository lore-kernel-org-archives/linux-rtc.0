Return-Path: <linux-rtc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4CAEB64D0
	for <linux-rtc@archiver.kernel.org>; Tue, 13 Jun 2023 15:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242987AbjFMP1E (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Tue, 13 Jun 2023 11:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235642AbjFMP1E (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 13 Jun 2023 11:27:04 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BA0109;
        Tue, 13 Jun 2023 08:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686670023; x=1718206023;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0SIDUmMfNBgZeXy9i27rr+EM79cGhD2Ibj9Sfla/Xiw=;
  b=WzNpJj9LIpGjAwbubpTKGMP2WBX/22JZ7VDMWRDqgw/jrA5y7fPkyIHr
   AB2dTR6sbkaA/BC5LFsUSiThqmS166uQn2+lqDp5wV/xK4bKGtNmRYT/v
   MBc3xMBzsXsib5DadaibOJfVF5Wb+m4lHcd/Ifoe5vejxG8t456XaDbex
   sBYcOMi2wzkRoVS9FSTWW0RZnwz6HT9K4ap7bGTsniSxVMd6OxOYkaWy8
   c7Idd7xg3Sm+YsedetvgJpz52ZSp0oSwwhSFUzpALwqpEzPasDXGDVxEy
   l5iZf5ydwFVOegjfT91Tc4lqcqrJLTNW6Yset9A4otz6ipWEOe3Jlufx4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="361736047"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="361736047"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 08:26:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="958440913"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="958440913"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jun 2023 08:26:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1q95uu-003UEY-0g;
        Tue, 13 Jun 2023 18:26:44 +0300
Date:   Tue, 13 Jun 2023 18:26:43 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] rtc: isl12022: battery backup voltage and clock
 support
Message-ID: <ZIiKs5IHOYnNaNhk@smile.fi.intel.com>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230613130011.305589-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613130011.305589-1-linux@rasmusvillemoes.dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

On Tue, Jun 13, 2023 at 03:00:02PM +0200, Rasmus Villemoes wrote:
> The current handling of the low-battery bits in the status register is
> wrong. The first six patches fix that and implement proper support for
> RTC_VL_READ.
> 
> The last two patches allow describing the isl12022 as a clock
> provider, for now just as a fixed 32kHz clock. They are also
> tangentially related to the backup battery, in that when the isl12022
> is not used as a clock source, one can save some power consumption in
> battery mode by setting the FOx bits to 0.

> v2 changes:

A nit-pick regarding to the process. You used In-reply-to email header and
this a bit inconvenient if you operate with a threads in MUA, for example,
I would like to delete old thread, but in this case it automatically marks
v2 for deletion (I'm using classical mutt).

-- 
With Best Regards,
Andy Shevchenko


