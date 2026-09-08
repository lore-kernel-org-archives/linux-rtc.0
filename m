Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7353A4B0499;
	Tue,  8 Sep 2026 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788861224; cv=none; b=KimlaD+PsjkM3SwIpf2n3aYpejCTRYKTLjPE2dDbM3YUueFKKTG1znT/sgAdvVP1f2Za1SHUAsIbgfySFvYDhb+MhZXQe6AH8CRiuCg3pLQi7kWMPXkvtCKaGYg9BFwTtuRTmm5iYDkqvQI+mlSnmRx7HoL+k3sDSFQpdbGLpyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788861224; c=relaxed/simple;
	bh=1bYPTTBJE4EIqut0Ao5jC56iCKbH8RRYeo09NvHSfMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AR1AN6op12f1BgpG+dXZsHn4O+tsFy+0AwclHgUXpFs9hwpxwt33w5o1guZRlu5LCYSxSGKIwD5rKi3TWe3PgQTo7bL2bO+E+siAn4sdbkI5w6hufA9hwwCjG8VODq/PVI55C10U92CEv9dLsOBrd9yXgOuaQ0A2HW76kkqtOxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EQxxhwEW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQxxhwEW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166441F00A3A;
	Tue,  8 Sep 2026 09:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788861223;
	bh=KAFabMVi0Pgmm1WEMfCrCU3N7GlwVdKzwoJnEuEF+do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EQxxhwEWxRl3taSy5kHVHMXlRMGqgFbAR7fxHhm/n3RFcVrtLvXztK9A41ZxXBlb/
	 7ikqmh14APZmCAWErb4HkDSmph59D97CitojF7ma7EIIm55blAY5Npo6iupzFV8hgg
	 djTty7CRaXkMquwiQLto8Oa+SQfHKfTmpT+fyyCzVi5xUwxVxCFVYrg+US4QRVa1pK
	 eJgB3d8K9zL3nULVtIXMn18BJkZp6e0sCp6J7gGayTyhmpr3/nSRoe72ZiskKy1gzy
	 8jFAJsqzOORxwbIalrmxJjCO2drMqkq8YIKUep/c6xvCLlbrdyu+pJr0QPW9rD+whq
	 pyt7REOSohN+g==
Date: Tue, 8 Sep 2026 11:53:38 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Satya Priya <quic_c_skakit@quicinc.com>, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Dhruvin Rajpura <dhruvin.rajpura@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: rtc: qcom-pm8xxx: Document PMM8654AU RTC
Message-ID: <20260908-witty-sapphire-mamba-1e5cc7@quoll>
References: <20260904074541.590485-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260904074541.590485-1-shengchao.guo@oss.qualcomm.com>

On Fri, Sep 04, 2026 at 03:45:41PM +0800, Shawn Guo wrote:
> Document Qualcomm PMM8654AU PMIC RTC which is compatible with PMK8350
> RTC.
> 
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Best regards,
Krzysztof

