Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5819A355048;
	Thu, 20 Aug 2026 21:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787261330; cv=none; b=mZ6XdkUSJi/dY6ZHKyCRVEEYsPbTugY4wb71Cl2IzS6v10APgLU+13Cd7DABXop/7zk+3FtA/nqbf2BQD+4abJTDAqWivFax98PwB2bwQbMRSYBKPKtAf80B959Osd3Em1P+IpAtafFR2Fn6Z4mCvj8mmUEYX5q0Cnt7ftYGL9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787261330; c=relaxed/simple;
	bh=M9KxGATqbPp8ussVdujbZJZTABgQ56rUmd/+TIs1aOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sR3uKn6+bUAzlLPJxEF274UGeSWikPD2HEGXpwCOuoMVZRujVMzzA1gTO006bmkCgSP/qAkOg6mu1Ud9huTZOXa1W+qXSNvPPfqRrSGzeVJIqvLicOxh0p2X3oaMmxEbt/ty3XerE5cnlqxqQBVhXmlXZgwN6YOOd8mzk2WsvjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=bBGVMBpL; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="bBGVMBpL"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id C65314E4130C;
	Thu, 20 Aug 2026 21:28:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 92F025FF59;
	Thu, 20 Aug 2026 21:28:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5544B11C7687F;
	Thu, 20 Aug 2026 23:28:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787261323; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=2RRzTf15BWKNMGMt8MDiUuiFNGiUIoGkX1Ztk/Dh/Ck=;
	b=bBGVMBpLdEfWHqaHi2z/uo+r9reVl7kvZw1oMwkKKjwgc492Jid9t2UDYWOAhxQcetVbgz
	GbjyL8xzQvK4+96qa7A8qxSJxmZQRfAGFc/4lkV57pm6LWMfYyvpjWGfMbBGJjbUv8nLYa
	Ypv+dKAt/+sffLUee6HwmpRLhSLlWOn4evRWQJFy/Y2jcpdZTsN4yiWqAOyjxiuokbLH1Z
	G4FFKKzMzt5L9b8r50Lt+XbCQ4CIMBc9MwrEFxlmMVMya0y53RrIpb4qz0WfatCXiAAx3b
	emIL2qp3hjMY1fRMxNzJRd2a7qQMPsfZT8FBNT+s7xA1hO/Nym26j6QvM1mGIA==
Date: Thu, 20 Aug 2026 23:28:41 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Julia.Lawall@inria.fr, Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: cocci@inria.fr, linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: (subset) [PATCH 29/36] rtc: pcf2127: remove conditional return
 with no effect
Message-ID: <178726066531.423710.3877565026736920974.b4-ty@b4>
References: <20260723184538.3888637-30-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723184538.3888637-30-ekffu200098@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 24 Jul 2026 03:45:31 +0900, Sang-Heon Jeon wrote:
> Both branches of the check return the same value, so the check has
> no effect. Remove it and return the value directly.
> 
> This is the result of running the Coccinelle script from
> scripts/coccinelle/misc/cond_return_no_effect.cocci.
> 
> 
> [...]

Applied, thanks!

[29/36] rtc: pcf2127: remove conditional return with no effect
        https://git.kernel.org/abelloni/c/b1407862fb57

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
