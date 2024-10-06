Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536DFA920;
	Sun,  6 Oct 2024 00:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728176322; cv=none; b=ZSciJitRZODCshT62yS30Gp7bPled5oh188H2MskvITjssbnNTd6Kq8BH6v6mCAaY7dbD6I6fevuqPqUHi+HClVMiJOVqXr9qclnof11moctFSXV3blSpRPXVXBZ6XxJLTPG9Ptenie9H6ievZ1jrcBdzOvlOJo3MfY1N4UmcZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728176322; c=relaxed/simple;
	bh=8SvLF04GIF+3hLNbA41pmSdjhO9vcS2WSPri+qiZvcw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QeioVKFGE+kl/yDbkq+me/p6xu4gmksl1owo25CusQKpdUxc+r4ELYCp4V4VaySzeZTkWpVi+KSHCSZpgQIICycpYlU7VBiA5V5EQXrm+cv408KVD6Bvh9NhY49rGG+NkMssHi8xLCDjwM3MpNv6/sT67OR2lQkhB9jVV+c5YTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 0F5B192009C; Sun,  6 Oct 2024 02:58:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 050E892009B;
	Sun,  6 Oct 2024 01:58:30 +0100 (BST)
Date: Sun, 6 Oct 2024 01:58:30 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
cc: alexandre.belloni@bootlin.com, linux-rtc@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: rtc-mc146818-lib: Use is_leap_year instead of
 calculate leap years
In-Reply-To: <20241006001553.7430-1-iwamatsu@nigauri.org>
Message-ID: <alpine.DEB.2.21.2410060143320.45128@angie.orcam.me.uk>
References: <20241006001553.7430-1-iwamatsu@nigauri.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 6 Oct 2024, Nobuhiro Iwamatsu wrote:

> The is_leap_year() for determining leap year is provided in rtc lib.
> This uses is_leap_year() instead of its own leap year determination
> routine.

 Good catch!  As a DECstation maintainer:

Acked-by: Maciej W. Rozycki <macro@orcam.me.uk>

Thank you for making this clean-up to this 22 years old code!

  Maciej
