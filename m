Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8E31F4176;
	Fri,  8 May 2026 02:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778206184; cv=none; b=FD14MWqq37Vr1TDaVqWe7Y0TchYlXuhQZOJ07kAvIMkJoRLhFwzFTbBPbk40lJAIdKrv2LZRXJCMGqWFIfU2CuxZwK9Xp3x9QVHoyGeZD7400CAH3iCpt6NAgWo/t5bzT3ABHX5tgtg/kXLBylr7U1SnkrBLwAMLvqdQrmkCe/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778206184; c=relaxed/simple;
	bh=iPMhb6UP2TqRypwHU6eLXgB/wuE1FQB73LYt63Zl9rQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J4dl1BwwDVPXKSN6Iuc4hB/cbw743JVHOz7uOQ0VA6v8nGf8baBM/ToMQkF8z7OjBfAzWs52VLBsLgqXIhAnoKSS0/wz9XHprMNKNd3BBZCksfFTDEbVB+gETWmgPUmL0pikmrgk/EuGPpvgW/cQr9ljlEp1Disq08g48dbuj0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LtIeCe7t; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LtIeCe7t"
Received: from [100.64.160.40] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id CC3E620B7165;
	Thu,  7 May 2026 19:09:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CC3E620B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778206179;
	bh=iPMhb6UP2TqRypwHU6eLXgB/wuE1FQB73LYt63Zl9rQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LtIeCe7tOLaejOUB1KnVQjgHraznJceMvSfM2fQDM/UAONwtTKFJWAuRvHMcvsZ5M
	 w0xNrhsyfSwEqYLFf0MGuKoTGHcqFl0tBBjGb6szJTodEL6fxieQDpQAhAQMhw9LlW
	 bjW1+szlG4s8lLbYxap1hK8pbi1d9KgpA5dET+dY=
Message-ID: <0ef9de5c-4b1d-461a-98e9-b04fb430fdde@linux.microsoft.com>
Date: Thu, 7 May 2026 19:09:42 -0700
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rtc: ds1307: handle oscillator stop flag for
 ds1337/ds1339/ds3231
To: Ronan Dalton <ronan.dalton@alliedtelesis.co.nz>,
 alexandre.belloni@bootlin.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Tyler Hicks <code@tyhicks.com>, Sasha Levin <sashal@kernel.org>,
 Rodolfo Giometti <giometti@enneenne.com>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>
References: <20260501044657.1003980-2-ronan.dalton@alliedtelesis.co.nz>
Content-Language: en-US
From: Meagan Lloyd <meaganlloyd@linux.microsoft.com>
In-Reply-To: <20260501044657.1003980-2-ronan.dalton@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 4/30/2026 9:46 PM, Ronan Dalton wrote:
> An alternative to this change could be just to revert the referenced two
> commits and not use the OSF bit at all, apart from logging a warning and
> clearing it on probe.
Can you remove this from the commit message?
