Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415A4194C98;
	Sat, 21 Feb 2026 10:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771669333; cv=none; b=XC1sX+k1nqwhvD2XvD297MG6x+xvH7bSCbMR+EYgu/SEj/sfjO86A5McmUNBESBnH+QQuhKG/wJdMbLg7Wanee/SbwGmGQQwYeZ4oPECDWz64IW0rvLqmZyi6mCRl4Tf1PCYqdqBoxni3qjBa5/hp9t9vBQ30rvqLxaBuqPHwKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771669333; c=relaxed/simple;
	bh=SCCQgKWFY0RoWHOvDvOE6dkHo2sUFoGPMR9rp72YnPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KlEiE95KoeFwhpXN2gHDeMfcsLn9eqSMEWCjomRnP/5IyZEZoz6aPkQcegIz75twyXfpUJy2GpvQnXCsGKCdwi+mljaKWO6pd8tlg/CynQvw/MjgQ7TEU0r4qrr/KJsH+rDr2Ns6biQq+VaKh5PW2ptTmpo76kr++zoV5ojm3aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aANsUBK1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aANsUBK1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B76C4CEF7;
	Sat, 21 Feb 2026 10:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771669332;
	bh=SCCQgKWFY0RoWHOvDvOE6dkHo2sUFoGPMR9rp72YnPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aANsUBK1RXrEwi3KcgnayUI9H2zscZNN8E/dhwe7mt2Ps4tB8AAa/pndsy0MIaWgZ
	 WKTgzLDuB40Xx+iyVCqOIIDAOblKmnvi+GeWzwdLHAdEULrhXR2K3eZtJFpMVctGnZ
	 C/kl69XcfOyQFpRQL1jr+r4xVEavKQjGJyqLXrxjR8EoJI78RWypP2uDWNivsoXs2r
	 35ZXx4q+yFbYFnI/fA0gjCiQHngnTMWmU/pYa4RY+1XS1qBe9COghb5j33moUY6yPO
	 zh4tOR3QDPNi3DPTaf7YdXbZXBOINPXydtHPjQCE6tNjJvr5Nv3nCxu/X6aspJuuA2
	 2oX/TedUrOwtw==
Date: Sat, 21 Feb 2026 11:22:10 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: rtc: isl12026: convert to YAML schema
Message-ID: <20260221-seahorse-of-luxurious-youth-dbc117@quoll>
References: <20260220-vigorous-holistic-platypus-6ebebd@quoll>
 <20260220084723.171639-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260220084723.171639-1-piyushpatle228@gmail.com>

On Fri, Feb 20, 2026 at 02:17:23PM +0530, Piyush Patle wrote:
> Convert the ISL12026 RTC binding from text format to YAML schema.
> Remove the legacy text binding.
> 
> The new schema enables dtbs_check validation.
> ---
> Changes in v2:
> - Fixed schema validation issues pointed out in review
> - Improved example node formatting
> - Removed redundant description text
> 
> ---
> Changes in v3:
> - Dropped unnecessary block scalar ('|') in description
> - Removed unsupported select section to match existing RTC bindings

Where?

> - Aligned schema structure with other RTC YAML bindings
> - Fixed YAML formatting and dt_binding_check errors
> 
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>

Do not attach (thread) your patchsets to some other threads (unrelated
or older versions). This buries them deep in the mailbox and might
interfere with applying entire sets. See also:
https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/submitting-patches.rst#L830

Best regards,
Krzysztof

